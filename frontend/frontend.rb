require 'sinatra/param'
require 'exchange_rates'

class Frontend < Sinatra::Base

  helpers Sinatra::Param

  set :public_folder => "public", :static => true

  get "/" do
    fx = ExchangeRate.new(ECBFormatter.new)
    erb :index, :locals => {
      :currencies => fx.list_currencies,
      :dates => fx.list_dates,
      :amount => "100.00",
      :from_currency => "GBP",
      :to_currency => "USD"
    }
  end

  post "/" do

    fx = ExchangeRate.new(ECBFormatter.new)

    currencies = fx.list_currencies
    dates = fx.list_dates

    param :amount,          Float, required: true
    param :date,            String, required: true
    param :from_currency,   String, required: true
    param :to_currency,     String, required: true

    one_of :from_currency, currencies
    one_of :to_currency, currencies
    one_of :date, dates

    amount = params["amount"].to_f
    date = params["date"]
    from_currency = params["from_currency"]
    to_currency = params["to_currency"]
    rate = fx.at(date, from_currency, to_currency)
    result = calculate_result(amount, rate)

    erb :index, :locals => {
      :currencies => currencies,
      :dates => dates,
      :amount => amount,
      :date => date,
      :from_currency => from_currency,
      :to_currency => to_currency,
      :rate => rate,
      :result => result
    }

  end

  private

  def calculate_result(amount, rate)
    (amount.to_f * rate.to_f)
  end

end
