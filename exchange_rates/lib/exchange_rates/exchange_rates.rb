require "exchange_rates/formatters/ecb_formatter"

class ExchangeRate

  def initialize(formatter = nil)

    if formatter.nil?
      @data = ECBFormatter.new.format
    else
      @data = formatter.format
    end
  end

  def at(date, from, to)
    if is_base_currency(from) or is_base_currency(to)
      # If "from" is the same as the base currency (EUR) just lookup
      # the rate value, otherwise lookup and invert.
      rate = is_base_currency(from) ? rate(date, to) : invert(rate(date, from))
    else
      # Neither currency is base, so calculate cross rate.
      rate = cross_rate(rate(date, from), rate(date, to))
    end
    set_precision(rate)
  end

  def list_currencies
    @data[:rates].uniq{ |rate| rate[:currency] }
      .map{ |c| c[:currency] }
      .push(@data[:base_currency])
      .sort
  end

  def list_dates
    @data[:rates].uniq{ |date| date[:date] }
      .map{ |c| c[:date] }
      .sort
      .reverse
  end

  private

  def is_base_currency(currency)
    @data[:base_currency] == currency
  end

  def rate(date, currency)
    begin
      # Search rates array for a rate matching given date and currency, returning rate as a Float
      @data[:rates].find{|rate| (rate[:date] == date and rate[:currency] == currency) }[:rate].to_f
    rescue
      raise ArgumentError, "No match found for date and currency"
    end
  end

  def invert(rate)
    raise ZeroDivisionError, "Rate should be greater than zero" unless rate > 0
    (1 / rate)
  end

  def cross_rate(from_rate, to_rate)
    unless (from_rate > 0 and from_rate.is_a? Numeric) and (to_rate > 0 and to_rate.is_a? Numeric)
      raise ArgumentError, "Rates should be numbers greater than zero"
    end
    to_rate / from_rate
  end

  def set_precision(rate)
    ("%.4f" % rate).to_f
  end

end
