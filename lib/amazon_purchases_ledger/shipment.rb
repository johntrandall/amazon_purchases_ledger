require 'bigdecimal'
require 'bigdecimal/util'

module AmazonPurchasesLedger
  class Shipment
    def initialize(items_csv:, order_csv_row:)
      @items_csv = items_csv
      @order_csv_row = order_csv_row
    end

    def output_text
      [
        "Shipment: #{@order_csv_row[:carrier_name__tracking_number]}",
        items.map { |item| item.output_text },
        promotions_text
      ].compact.join("\n")
    end

    def items
      AmazonPurchasesLedger::Item::Factory.new(carrier_tracking: @order_csv_row[:carrier_name__tracking_number],
                                               items_csv: @items_csv)
        .items
    end

    def total_charged
      return nil unless @order_csv_row[:total_charged]
      @order_csv_row[:total_charged].gsub('$', '').to_d
    end

    private
    def promotions_text
      "* [#{@order_csv_row[:total_promotions]}] Promotions Credit" unless @order_csv_row[:total_promotions] == '$0.00'
    end

  end
end
