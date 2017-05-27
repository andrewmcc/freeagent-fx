require 'open-uri'

class DownloadFeed

  def initialize(source, target)
    @source = source
    @target = target
  end

  def download
    open(@target, 'wb') do |file|
      open(@source) do |uri|
        file.write(uri.read)
      end
    end
  end

end
