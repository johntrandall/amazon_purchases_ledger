module AmazonPurchasesLedger
  class Item
    def initialize(items_csv_row:)
      @items_csv_row = items_csv_row
    end

    def output_text
      [
        '* ',
        item_cost, ' for ',
        item_quantity_string, item_title, ', ',
        'Seller: ', item_seller
      ].join
    end

    def item_quantity_string
      "#{@items_csv_row[:quantity]}x " if @items_csv_row[:quantity]
    end

    private
    def item_seller
      @items_csv_row[:seller]
    end

    def item_title
      truncate(@items_csv_row[:title], 40)
    end

    def item_cost
      @items_csv_row[:item_total]
    end

    def truncate(content, max)
      if content.length > max
        truncated = ""
        collector = ""
        content = content.split(" ")
        content.each do |word|
          word = word + " "
          collector << word
          truncated << word if collector.length < max
        end
        truncated = truncated.strip.chomp(",").concat("...")
      else
        truncated = content
      end
      return truncated
    end

  end
end
