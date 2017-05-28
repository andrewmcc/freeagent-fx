require 'exchange_rates'

class Frontend < Sinatra::Base

  set :public_folder => "public", :static => true

  get "/" do
    fx = ExchangeRate.new(ECBFormatter.new)
    currencies = fx.list_currencies
    dates = fx.list_dates
    erb :index, :locals => {
      :currencies => currencies,
      :dates => dates,
      :amount => '100.00',
      :from_currency => 'GBP',
      :to_currency => 'USD'
    }
  end

  post "/" do
    fx = ExchangeRate.new(ECBFormatter.new)
    currencies = fx.list_currencies
    dates = fx.list_dates
    amount = params["amount"].to_f
    date = params["date"]
    rate = fx.at(date, params["from"], params["to"])
    result = (amount.to_f * rate.to_f)
    erb :index, :locals => {
      :currencies => currencies,
      :dates => dates,
      :amount => params["amount"],
      :date => params["date"],
      :from_currency => params["from"],
      :to_currency => params["to"],
      :rate => rate,
      :result => result
    }
  end

end
