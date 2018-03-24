require 'csv'
module AmazonCsvCombiner

  class MergeService
    # include Thor::Actions

    def initialize(csv_path_1, csv_path_2)
      @csv_path_1 = csv_path_1
      @csv_path_2 = csv_path_2
      @csv1 = CSV.read(@csv_path_1)
      @csv2 = CSV.read(@csv_path_2)
    end

    def perform
      # test_if_csvs_are_valid
      # interleave_csvs
      # generate_output_file
    end

    def objects_csv

    end

    def items_csv

    end

  end
end
