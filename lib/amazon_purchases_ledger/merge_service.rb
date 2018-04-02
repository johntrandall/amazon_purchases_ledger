require 'csv'

module AmazonPurchasesLedger
  class MergeService

    def initialize(csv_path_1, csv_path_2)
      @csv_path_1 = csv_path_1
      @csv_path_2 = csv_path_2
      @csvs = [CSV.table(@csv_path_1, headers: true), CSV.table(@csv_path_2, headers: true)]
    end

    def perform
      CSV.open("output.csv", "wb") do |csv|
        csv << output_header_row
        orders.each do |order|
          csv << order.output_row
        end
      end
    end

    def orders
      AmazonPurchasesLedger::Order::Factory.new(orders_csv: orders_csv,
                                                items_csv: items_csv)
        .orders
    end

    def orders_csv
      csvs_with_header(:total_charged)
    end

    def items_csv
      csvs_with_header(:title)
    end

    def output_header_row
      AmazonPurchasesLedger::Order::OUTPUT_HEADER_ROW
    end

    private
      class InvalidInputCsvs < StandardError;
      end

      def csvs_with_header(header)
        csvs = @csvs.select { |csv| csv.headers.include?(header) }
        raise InvalidInputCsvs unless csvs.count == 1
        csvs.first
      end

  end
end
