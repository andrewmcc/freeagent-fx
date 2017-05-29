require "exchange_rates/formatters/formatter"
require "exchange_rates/save_feed"

class ECBFormatter < Formatter

  def initialize
    @xml_file = File.join(File.dirname(__FILE__), "../data/latest.xml")

    # Save feed to file if it doesn't exist
    unless File.exist?(@xml_file)
      SaveFeed.new("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml", @xml_file).to_disk
    end

    file_to_hash
  end

  def format
    @fx_rates = { :base_currency => "EUR", :rates => [] }
    @ecb_rates["Envelope"]["Cube"]["Cube"].each do |day|
      day["Cube"].each do |pair|
        rate = { :date => day["@time"], :currency => pair["@currency"], :rate => pair["@rate"] }
        @fx_rates[:rates].push(rate)
      end
    end
    @fx_rates
  end

end
