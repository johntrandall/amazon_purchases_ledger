module AmazonCsvCombiner
  class NoteCellGenerator
    attr_reader :shipment_row, :items_csv

    def initialize(like_order_shipment_rows:, items_csv:)
      @like_order_shipment_rows = like_order_shipment_rows
      @order_id = like_order_shipment_rows.first[:order_id]
      @items_csv = items_csv
    end

    def note_cell
      shipments.map(&:shipment_output_lines)
    end

    # def shipments_text
    #   like_order_shipment_rows.map do |shipment_row|
    #     [
    #       shipment_header_line,
    #       item_lines,
    #       other_lines
    #     ].join("\n")
    #     # [shipment_row_item_details, shipment_row_details, shipment_row_total].join("\n")
    #   end
    # end
    #
    # private
    # def shipment_header_line
    #   "delivered on: DELIVERY DATE (TRACKING NUM)"
    # end
    #
    # def items_lines
    #   # shipment_items
    #   # item_lines_for()
    # end


      # def order_text
      #   'order row text here'
      # end
      #
      #
      # private

      #
      # def item_row_lines
      #   matching_item_rows.map { |item_row| item_lines(item_row) }.join("\n")
      # end
      #
      # def other_lines
      #   [order_shipping_line, tax_line, promotions_line].compact.join("\n")
      # end
      #
      # def matching_item_rows
      #   items_csv.select do |row|
      #     row[:order_id] == @order_id &&
      #       row[:carrier_name__tracking_number] == shipment_row[:carrier_name__tracking_number]
      #   end
      # end
      #
      #

      #
      # def tax_line
      #   "#{shipment_row[:tax_charged]} Tax" if shipment_row[:tax_charged] != "$0.00"
      # end
      #
      # def promotions_line
      #   "-#{shipment_row[:total_promotions]} Promotions Credit" if shipment_row[:total_promotions] != "$0.00"
      # end
      #
      # def total_line
      #   "--------\n #{shipment_row[:total_charged]} Total" if [item_row_lines, other_lines].compact.count > 1
      # end

  end
end
