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
        end
      end

      def order_ids
        @orders_csv[:order_id]
      end
    end

    def initialize(order_id: order_id, orders_csv: @orders_csv, items_csv: @items_csv)
      @order_id = order_id
      @orders_csv = orders_csv
      @items_csv = items_csv
    end

    OUTPUT_HEADER_ROW = [
      :order_date,
      :payment_account,
      :amount,
      :memo
    ]

    def output_row
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
      shipment_rows.map { |row| row[:total_charged]&.gsub('$', '')&.to_d }
        .compact
        .sum.to_f.to_s.prepend('$')
    end

    def money_from_string(currency_notation_string)
      raise unless currency_notation_string && currency_notation_string != ''
      MoneyParser.parse_to_decimal(currency_notation_string)
    end

  end

end
