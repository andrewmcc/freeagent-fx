require_relative 'formatter'

class ECBFormatter < Formatter

  def initialize(xml_file = '../../data/latest.xml')
    @xml_file = xml_file
    file_to_hash
  end

  def format
    @fx_rates = { :base_currency => 'EUR', :rates => [] }
    @ecb_rates['Envelope']['Cube']['Cube'].each do |day|
      day['Cube'].each do |pair|
        rate = { :date => day['@time'], :currency => pair['@currency'], :rate => pair['@rate'] }
        @fx_rates[:rates].push(rate)
      end
    end
    @fx_rates
  end

end
