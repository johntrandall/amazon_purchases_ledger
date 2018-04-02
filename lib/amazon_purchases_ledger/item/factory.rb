module AmazonPurchasesLedger
  class Item
    class Factory
      def initialize(items_csv:, carrier_tracking:)
        @items_csv = items_csv
        @carrier_tracking = carrier_tracking
      end

      def items
        items_csv_rows = @items_csv.select { |row| row[:carrier_name__tracking_number] == @carrier_tracking }
        items_csv_rows.map { |items_csv_row| Item.new(items_csv_row: items_csv_row) }
      end
    end
  end
end
