require "amazon_purchases_ledger/version"
require "amazon_purchases_ledger/merge_service"
require "amazon_purchases_ledger/order"
require "amazon_purchases_ledger/order/factory"
require "amazon_purchases_ledger/shipment"
require "amazon_purchases_ledger/shipment/factory"
require "amazon_purchases_ledger/item"
require "amazon_purchases_ledger/item/factory"

require 'thor'

module AmazonPurchasesLedger
  # Your code goes here...
  class CLI < Thor

    desc 'merge [orders.csv] [items.csv]', 'render transactions CSV at user\'s home_dir'

    def merge(csv_path_1, csv_path_2)
      AmazonPurchasesLedger::MergeService.new(csv_path_1, csv_path_2).perform
    end

  end
end

