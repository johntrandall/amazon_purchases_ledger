module AmazonCsvCombiner
  class OutputRowGenerator

    OUTPUT_HEADERS = OUTPUT_HEADERS_PART1 + [:details] + OUTPUT_HEADERS_PART2
    OUTPUT_HEADERS_PART1 = [
      :order_date,
      :total_charged,
      :payment_instrument_type
    ]
    OUTPUT_HEADERS_PART2 = [
      :order_id,
    # :shipment_date,
    # :shipping_address_name,
    # :shipping_address_street_1,
    # :shipping_address_street_2,
    # :shipping_address_city,
    # :shipping_address_state,
    # :shipping_address_zip,
    # :carrier_name__tracking_number
    ]

    # RELEVANT_ORDER_HEADERS = RELEVANT_ORDER_HEADERS_PART1.concat(RELEVANT_ORDER_HEADERS_PART2)


    def initialize(order_id:, like_order_shipment_rows:, items_csv:)
      @order_id = grouped_order_rows.first
      @like_order_shipment_rows = like_order_shipment_rows
      @items_csv = items_csv
    end


    def output_row
      [
        order.order_date,
        order.total_charged
        order.payment_type,
        NoteCellGenerator.new(like_order_shipment_rows: @like_order_shipment_rows, items_csv: items_csv).note_cell,
        order.order_id
      ]
    end

    def order_date
      first_shipment_row[:order_date]
    end

    def payment_type
      first_shipment_row[:payment_type]
    end

    def total_charged
      like_order_shipment_rows.sum { |row| row[:total_charged] }
    end


    private
    def first_shipment_row
      like_order_shipment_rows.first
    end
  end
end
