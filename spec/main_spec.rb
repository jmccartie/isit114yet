require File.dirname(__FILE__) + '/spec_helper'

describe 'the main app' do
  it "is successful" do
    visit '/'
    page.should have_content("Oklahoma City")
  end

  context "when temp is < 114" do
    it "says not yet" do
      Dalli::Client.new.delete('is_it_114')
      WeatherUnderground::Base.stub_chain(:new, :CurrentObservations, :temp_f, :to_f) {113.0}
      visit '/'
      page.should have_content("Nope. It's only")
    end
  end

  context "when temp is >= 114" do
    it "says YES!" do
      Dalli::Client.new.delete('is_it_114')
      WeatherUnderground::Base.stub_chain(:new, :CurrentObservations, :temp_f, :to_f) {114.0}
      visit '/'
      page.should have_content("YES!")
    end
  end

  context "when switch flipped in cache" do
    before(:each) do
      @time = Time.now
      Dalli::Client.new.set('is_it_114', true)
      Dalli::Client.new.set('record_set_at', @time)
    end

    it "says YES!" do
      visit '/'
      page.should have_content("YES!")
    end

    it "spits out the time set" do
      visit '/'
      page.should have_content( @time.strftime("%I:%M%p") )
    end

  end

end