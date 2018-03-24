require "amazon_csv_combiner/version"
require "amazon_csv_combiner/merge_service"

require 'thor'

module AmazonCsvCombiner
  # Your code goes here...
  class CLI < Thor

    desc "merge", "merges csvs"

    def merge(csv_path_1, csv_path_2)
      AmazonCsvCombiner::MergeService.new(csv_path_1, csv_path_2).perform
    end

  end
end

