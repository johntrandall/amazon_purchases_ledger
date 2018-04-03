module AmazonPurchasesLedger
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
        @orders_csv[:order_id].uniq
      end
    end
  end
end
