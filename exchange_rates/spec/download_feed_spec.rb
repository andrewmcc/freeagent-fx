require_relative '../lib/exchange_rates'

describe DownloadFeed do

  feed_source = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  file_target = File.join(File.dirname(__FILE__), 'spec.xml')

  before :each do
    @feed_downloader = DownloadFeed.new(feed_source, file_target)
  end

  after :each do
    File.delete(file_target)
  end

  describe "download" do

    it "creates a file at target" do
      expect(@feed_downloader.download()).to be > 0 # in bytes
    end

  end

end
