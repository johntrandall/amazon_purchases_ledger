module AmazonPurchasesLedger
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
  end
end
