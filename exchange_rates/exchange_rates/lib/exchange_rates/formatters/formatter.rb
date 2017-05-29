require 'nori'

class Formatter

  def initialize(xml_file)
    @xml_file = xml_file
  end

  def file_to_hash
    nori = Nori.new(:strip_namespaces => true)
    @ecb_rates = nori.parse(File.open(@xml_file).read)
  end

  def format
    raise NotImplementedError
  end

end
