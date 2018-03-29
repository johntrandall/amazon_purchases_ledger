module AmazonCsvCombiner
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


    def initialize(items_csv_row:)
      @items_csv_row = items_csv_row
    end

    def output_text
      [
        '* ',
        @items_csv_row[:item_total], ' for ',
        item_quantity_string,
        @items_csv_row[:title], ', ',
        'Seller: ', @items_csv_row[:seller]
      ].join
    end

    def item_quantity_string
      "#{@items_csv_row[:quantity]}x " if @items_csv_row[:quantity]
    end

  end
end
