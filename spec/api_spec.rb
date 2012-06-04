require_relative "../api"
require "rspec"
require "rack/test"

set :environment, :test

describe "The Api" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    LogRequest.clear_log!
    LogRequest.log_request(6.seconds.ago.utc, "Hello World")
  end

  it "should return json array of log request" do
    get "/"
    json = JSON.parse(last_response.body)
    log_request = json.first["logrequest"]
    log_request.fetch("text").should eq("Hello World")
    time_in_utc = Time.parse(log_request.fetch("time"))
    time_in_utc.should be_within(1).of(6.seconds.ago.utc)
  end

  it "not be ok with /wack" do
    get "/wack"
    last_response.should_not be_ok
  end
end


describe LogRequest do

  let(:subject) { LogRequest.new(45.minutes.ago, "Just Record it")}

  it "should have the text" do
    subject.text.should eq("Just Record it")
  end
  it "should keep the time" do
    subject.time.should be_within(0.01).of(45.minutes.ago)
  end

  describe ":log" do
    before do
      LogRequest.clear_log!
      LogRequest.log_request(Time.now, "Now")
      LogRequest.log_request(Time.now, "Now")
    end
    it "should be an array-like thing" do
      LogRequest.log.count.should eq(2)
    end
    it "should request LogRequest" do
      LogRequest.log.first.should be_a(LogRequest)
    end

    it "can clear out the log" do
      LogRequest.clear_log!
      LogRequest.log.should be_empty
    end

  end
end
