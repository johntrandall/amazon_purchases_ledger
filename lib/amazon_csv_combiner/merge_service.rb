require 'csv'

module AmazonCsvCombiner

  class MergeService

    def initialize(csv_path_1, csv_path_2)
      @csv_path_1 = csv_path_1
      @csv_path_2 = csv_path_2
      @csvs = [CSV.table(@csv_path_1, headers: true), CSV.table(@csv_path_2, headers: true)]
    end

    def perform
      CSV.open("output.csv", "wb") do |csv|
        csv << output_header_row
        output_order_rows.each do |output_row|
          csv << output_row
        end
      end
    end

    def orders_csv
      csvs_with_header(:total_charged)
    end

    def items_csv
      csvs_with_header(:title)
    end

    class InvalidInputCsvs < StandardError;
    end

    def output_header_row
      OrderRowGenerator::RELEVANT_ORDER_HEADERS + [:item_details]
    end

    def output_order_rows
      orders_csv.map do |order_row|
        OrderRowGenerator.new(order_row, items_csv).filtered_order_row
      end
    end

    private
    def csvs_with_header(header)
      csvs = @csvs.select { |csv| csv.headers.include?(header) }
      raise InvalidInputCsvs unless csvs.count == 1
      csvs.first
    end

    class OrderRowGenerator

      RELEVANT_ORDER_HEADERS_PART1 = [:order_date,
                                      :shipment_date,
                                      :total_charged,
                                      :payment_instrument_type,
      ]
      RELEVANT_ORDER_HEADERS_PART2 = [:order_id,
                                      :shipping_address_name,
                                      :shipping_address_street_1,
                                      :shipping_address_street_2,
                                      :shipping_address_city,
                                      :shipping_address_state,
                                      :shipping_address_zip,
                                      :carrier_name__tracking_number]
      RELEVANT_ORDER_HEADERS = RELEVANT_ORDER_HEADERS_PART1.concat(RELEVANT_ORDER_HEADERS_PART2)

      attr_reader :order_row, :items_csv

      def initialize(order_row, items_csv)
        @order_row = order_row
        @items_csv = items_csv
      end

      def filtered_order_row
        data_from_orders_csv_array = RELEVANT_ORDER_HEADERS.map do |relevant_order_header|
          order_row[relevant_order_header]
        end

        data_from_orders_csv_array + [NoteCellGenerator.new(order_row, items_csv).note]
      end
    end


    class NoteCellGenerator
      attr_reader :order_row, :items_csv

      def initialize(order_row, items_csv)
        @order_row = order_row
        @items_csv = items_csv
      end

      def note
        [item_row_lines, other_lines, total_line].compact.join("\n")
      end

      private
      def other_lines
        [order_shipping_line, tax_line, promotions_line].compact.join("\n")
      end

      def item_row_lines
        matching_item_rows.map { |item_row| item_lines(item_row) }.join("\n")
      end

      def matching_item_rows
        items_csv.select do |row|
          row[:order_id] == order_row[:order_id] &&
            row[:carrier_name__tracking_number] == order_row[:carrier_name__tracking_number]
        end
      end

      def item_lines(item_row)
        [item_row[:item_total], ', ', item_quantity_string(item_row), item_row[:title], ', Seller: ', item_row[:seller]].join
      end

      def item_quantity_string(item_row)
        "#{item_row[:quantity]}x " if item_row[:quantity]
      end

      def order_shipping_line
        "#{order_row[:shipping_charge]} Shipping" if order_row[:shipping_charge] != "$0.00"
      end

      def tax_line
        "#{order_row[:tax_charged]} Tax" if order_row[:tax_charged] != "$0.00"
      end

      def promotions_line
        "-#{order_row[:total_promotions]} Promotions Credit" if order_row[:total_promotions] != "$0.00"
      end

      def total_line
        "--------\n #{order_row[:total_charged]} Total" if [item_row_lines, other_lines].compact.count > 1
      end

    end
  end
end
