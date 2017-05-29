require 'open-uri'

class SaveFeed

  def initialize(source, target)
    @source = source
    @target = target
  end

  def to_disk
    begin
      open(@target, 'wb') do |file|
        open(@source) do |uri|
          file.write(uri.read)
        end
      end
    rescue => exception
      puts "#{exception.class}: #{ex.message}"
    end
  end

end
