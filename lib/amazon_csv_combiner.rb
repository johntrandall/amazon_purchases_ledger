require "amazon_csv_combiner/version"

require 'thor'

module AmazonCsvCombiner
  # Your code goes here...
  class CLI < Thor
    desc "hello world", "my first cli yay"
    def hello(name)
      if name == "Heisenberg"
        puts "you are goddman right"
      else
        puts "say my name"
      end
    end

  end
end

