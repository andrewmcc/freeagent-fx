require 'nori'

class Formatter

  def initialize(xml_file)
    @xml_file = xml_file
  end

  def file_to_hash
    nori = Nori.new(:strip_namespaces => true)
    @ecb_rates = nori.parse(File.open(@xml_file).read)
  end

  # Formatter subclasses should implement a "format" method that returns
  # the following data structure:
  #
  # { :base_currency => 'EUR'
  #   :rates => [
  #     { :date => '2017-05-29', :currency => 'GBP', :rate => '1.234' },
  #     { :date => '2017-05-29', :currency => 'EUR', :rate => '1.234' },
  #     { :date => '2017-05-29', :currency => 'USD', :rate => '1.234' },
  #     { :date => '2017-05-28', :currency => 'GBP', :rate => '1.234' },
  #     { :date => '2017-05-28', :currency => 'GBP', :rate => '1.234' },
  #     { :date => '2017-05-28', :currency => 'GBP', :rate => '1.234' },
  #     { ... }
  #   ]
  # }

  def format
    raise NotImplementedError
  end

end
