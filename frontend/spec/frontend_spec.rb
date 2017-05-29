require_relative "spec_helper"
require_relative "../frontend.rb"

def app
  Frontend
end

describe Frontend do
  it "responds with a welcome message" do
    get '/'

    last_response.body.must_include 'Amount'
  end
end
