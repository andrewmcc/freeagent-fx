require "exchange_rates/exchange_rates"

class TestFormatter
  def format
    {
      :base_currency => "EUR",
      :rates => [
        { :date => "2017-05-25", :currency => "GBP", :rate => "0.8719" },
        { :date => "2017-05-25", :currency => "HUF", :rate => "307.4" },
        { :date => "2017-05-25", :currency => "RON", :rate => "4.5568" },
        { :date => "2017-05-25", :currency => "ILS", :rate => "4.0008" },
        { :date => "2017-05-24", :currency => "GBP", :rate => "0.8210" },
        { :date => "2017-05-24", :currency => "HUF", :rate => "305.9" },
        { :date => "2017-05-24", :currency => "RON", :rate => "4.5664" },
        { :date => "2017-05-24", :currency => "ILS", :rate => "4.0108" }
      ]
    }
  end
end

describe ExchangeRate do

  before :each do
    @fx = ExchangeRate.new(TestFormatter.new)
  end

  describe "list currencies" do

    it "returns a unique list of currencies" do
      expect(@fx.list_currencies.length).to eq(5) # 4 from test data above, plus base_currency
    end

    it "returns a sorted list of currencies" do
      expect(@fx.list_currencies[0]).to eq("EUR")
      expect(@fx.list_currencies[1]).to eq("GBP")
      expect(@fx.list_currencies[2]).to eq("HUF")
      expect(@fx.list_currencies[3]).to eq("ILS")
      expect(@fx.list_currencies[4]).to eq("RON")
    end

  end

  describe "list dates" do

    it "returns a unique list of dates" do
      expect(@fx.list_dates.length).to eq(2)
    end

    it "returns a reverse sorted list of dates" do
      expect(@fx.list_dates[0]).to eq("2017-05-25")
      expect(@fx.list_dates[1]).to eq("2017-05-24")
    end

  end

  describe "rate" do

    it "returns a float" do
      expect(@fx.send(:rate, "2017-05-24", "GBP")).to be_a_kind_of(Numeric)
    end

    it "returns the correct value" do
      expect(@fx.send(:rate, "2017-05-24", "GBP")).to eq(0.8210)
    end

    it "raises on unmatched date or currency" do
      expect{@fx.send(:rate, "1900-01-01", "GBP")}.to raise_error(ArgumentError)
      expect{@fx.send(:rate, "2017-05-25", "ABC")}.to raise_error(ArgumentError)
    end

  end

  describe "invert" do

    it "returns the correct value" do
      expect(@fx.send(:invert, 0.8719)).to eq(1.1469205184080744)
    end

    it "raises on division by zero" do
      expect{@fx.send(:invert, 0)}.to raise_error(ZeroDivisionError)
    end

  end

  describe "cross_rate" do

    it "returns the correct value" do
      expect(@fx.send(:cross_rate, 1, 1)).to eq(1)
      expect(@fx.send(:cross_rate, 0.8719, 307.4)).to eq(352.56336735864204) # GBP->HUF
      expect(@fx.send(:cross_rate, 307.4, 0.8719)).to eq(0.00283636955107352) # HUF->GBP
    end

    it "raises on invalid input" do
      expect{@fx.send(:cross_rate, 0, 0 )}.to raise_error(ArgumentError)
      expect{@fx.send(:cross_rate, 0, 1 )}.to raise_error(ArgumentError)
      expect{@fx.send(:cross_rate, 1, 0)}.to raise_error(ArgumentError)
      expect{@fx.send(:cross_rate, "1", 1)}.to raise_error(ArgumentError)
    end

  end

  describe "at (integration tests)" do

    it "returns the correct values" do
      expect(@fx.at("2017-05-25", "EUR", "GBP")).to eq(0.8719) # rate
      expect(@fx.at("2017-05-25", "GBP", "EUR")).to eq(1.1469) # invert
      expect(@fx.at("2017-05-25", "HUF", "ILS")).to eq(0.0130) # cross
    end

  end

end
