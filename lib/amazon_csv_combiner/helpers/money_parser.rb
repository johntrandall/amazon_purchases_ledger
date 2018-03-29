require 'bigdecimal'
require 'bigdecimal/util'

class MoneyParser

  def self.parse_to_decimal(money_string)
    money_string.gsub(/[^\d\.]/, '').to_d
  end
end
