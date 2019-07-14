# Amazon Purchases Ledger

This gem takes order and item CSVs downloaded from your Amazon account as input, and parses those into a transactions CSV which is created in your home folder. 

This output file is suitable for importing into a financial ledger system, such as Bankivity or Quicken. It contains fields for for transaction date, transaction amount, source account, and a memo. 

The memo field in the output file contains details for each order, including the items and shipment details. Having these details included in each transaction row can helps with categorizing transactions for tax or budgeting purposes.

To create the orders and items CSVs needed as input, see https://www.amazon.com/gp/help/customer/display.html


## TODO: 

[ ] Create a scraper that automatically downloads the source CSVs. See https://github.com/kyamaguchi/amazon_auth 


## Similar projects

* Amazon Order - Does similar things scraping he Amazon DOM rather than using CSVs. See https://github.com/kyamaguchi/amazon_order


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amazon_purchases_ledger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amazon_purchases_ledger


## Usage

After installing, bundle should be available at the command line via

    $ amazon_purchases_ledger

Pass in the filepaths to an Amazon orders csv and an Amazon items csv, and the gem will create a ```transactions.csv``` in the user's home folder:

    $ amazon_purchases_ledger merge [orders csv filepath] [items csv filepath]


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johntrandall/amazon_purchases_ledger.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
