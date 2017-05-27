Gem::Specification.new do |s|
  s.name        = 'exchange_rates'
  s.version     = '0.0.1'
  s.date        = '2017-05-25'
  s.summary     = "ECB Echange Rates"
  s.description = "Calculates exchage rates based on ECB XML feed"
  s.authors     = ["Andrew McCafferty"]
  s.email       = 'andrew.mccafferty@gmail.com'
  s.files       = ["lib/exchange_rates/exchange_rates.rb", "lib/exchange_rates/download_feed.rb", "lib/exchange_rates/formatters/formatter.rb", "lib/exchange_rates/formatters/ecb_formatter.rb"]
  s.license     = 'MIT'
end
