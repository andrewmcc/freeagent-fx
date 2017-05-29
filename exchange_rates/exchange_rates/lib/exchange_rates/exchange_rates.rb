require "exchange_rates/formatters/ecb_formatter"

class ExchangeRate

  def initialize(formatter = nil)

    # Default to ECB Formatter unless an alternative is supplied
    if formatter.nil?
      @data = ECBFormatter.new.format
    else
      @data = formatter.format
    end
  end

  def at(date, from, to)
    if is_base_currency(from) or is_base_currency(to)
      rate = is_base_currency(from) ? rate(date, to) : invert(rate(date, from))
    else
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
    ('%.4f' % rate).to_f
  end

end
