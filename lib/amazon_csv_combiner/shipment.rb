module AmazonCsvCombiner
  class Shipment
    class Factory
      def initialize(orders_csv:, items_csv:, order_id:)
        @orders_csv = orders_csv
        @items_csv = items_csv
        @order_id = order_id
      end

      def shipments
        order_csv_rows = @orders_csv.select { |row| row[:order_id] == @order_id }
        order_csv_rows.map { |order_csv_row| Shipment.new(items_csv: @items_csv, order_csv_row: order_csv_row) }
      end
    end

    def initialize(items_csv:, order_csv_row:)
      @items_csv = items_csv
      @order_csv_row = order_csv_row
    end

    def output_text
      [
        "Shipment: #{@order_csv_row[:carrier_name__tracking_number]}",
        items.map { |item| item.output_text },
        '----------------------'
      ].join("\n")
    end

    def total_charged
      return nil unless @order_csv_row[:total_charged]
      @order_csv_row[:total_charged].gsub('$', '').to_d
    end

    def items
      AmazonCsvCombiner::Item::Factory.new(carrier_tracking: @order_csv_row[:carrier_name__tracking_number],
                                           items_csv: @items_csv)
        .items
    end
  end


# subtotal
# shipping_charge
# total_promotions
# tax charged
# total_charged
end
