# Exchange Rates Library

## Installation

Add this line to your application's Gemfile, making sure :path is set to the root directory of the library.

```ruby
gem "exchange_rates", :path => "../exchange_rates"
```

Then execute:

    $ bundle install

## Usage

There are three available public methods:

```ruby
require("exchange_rates")

exchangeRate = ExchangeRate.new

# Return the exchange rate for selected date, base currency, and counter currency.
exchangeRate.at("2017-05-29", "GBP", "USD") #=> 1.2846

# Return an array of the available ISO 4217 currency codes.
exchangeRate.list_currencies() #=> ["AUD", "BGN", "BRL", "CAD", "..."]

# Return an array of dates for which conversion rate data is available.
exchangeRate.list_dates() #=> ["2017-05-29", "2017-05-28", "2017-05-27", "..."]
```
## Feed Download

The following rake task can be used to schedule a download of the European Central Bank 90-day XML feed:
```ruby
rake download
```

## Running Tests

To run the unit tests, use the default rake task:

    $ cd exchange_rates
    $ rake
