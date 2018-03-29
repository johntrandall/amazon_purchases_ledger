module AmazonCsvCombiner
  class OutputRowsGenerator

    def initialize(orders_csv:, items_csv:)
      @orders_csv = orders_csv
      @items_csv = items_csv
    end

    def output_rows
      [orders.map(&:output_rows)]
    end

  #   def output_rows
  #     like_order_id_shipment_row_groups.map do |shipment_row_group|
  #       OutputRowGenerator.new(
  #         order_id: shipment_row_group.first,
  #         like_order_shipment_rows: shipment_row_group.second,
  #         items_csv: items_csv
  #       ).output_row
  #     end
  #   end
  #
  # end
  #
  # def like_order_id_shipment_row_groups
  #   orders_csv.group_by do |row|
  #     row[:order_id]
  #   end
  # end
end
