module AmazonCsvCombiner
  class Order
    class Factory
      def initialize(orders_csv:, items_csv:)
        @orders_csv = orders_csv
        @items_csv = items_csv
      end

      def orders
        order_ids.map do |order_id|
          Order.new(order_id: order_id, orders_csv: @orders_csv, items_csv: @items_csv)
        end.select(&:complete?)
      end

      private
      def order_ids
        @orders_csv[:order_id]
      end
    end

    attr_reader :order_id

    def initialize(order_id: order_id, orders_csv: @orders_csv, items_csv: @items_csv)
      @order_id = order_id
      @orders_csv = orders_csv
      @items_csv = items_csv
    end

    def complete?
      amount != nil
    end

    OUTPUT_HEADER_ROW = [
      :order_date,
      :payment_account,
      :amount,
      :memo
    ]

    def output_row
      return nil if shipments.any? { |shipment| shipment.total_charged.nil? }
      [
        order_date,
        payment_account,
        amount,
        memo
      ]
    end

    def memo
      shipments.map(&:output_text).join("\n")
    end

    def shipments
      AmazonCsvCombiner::Shipment::Factory.new(order_id: @order_id,
                                               orders_csv: @orders_csv,
                                               items_csv: @items_csv)
        .shipments
    end

    def items
      shipments.flat_map(&:items)
    end

    private

    def shipment_rows
      @orders_csv.select { |row| row[:order_id] == @order_id }
    end

    def order_date
      shipment_rows.first[:order_date]
    end

    def payment_account
      shipment_rows.first[:payment_instrument_type]
    end

    def amount
      return nil if shipments.any? { |shipment| shipment.total_charged.nil? }
      shipments.map { |shipment| shipment.total_charged }
        .sum.to_f.to_s.prepend('$')
    end

    def money_from_string(currency_notation_string)
      raise unless currency_notation_string && currency_notation_string != ''
      MoneyParser.parse_to_decimal(currency_notation_string)
    end

  end

end
