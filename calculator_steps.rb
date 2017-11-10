require 'capybara/poltergeist'

Capybara.default_selector = :xpath
Capybara.add_selector(:tid) do
  xpath { |tid| ".//*[@data-testtoolid='" + tid + "']" }
end

Given(/^the (.*) application is running$/) do |arg1|
  url = 'http://snowball:8480/NaturalAjaxDemos/servlet/StartCISPage?PAGEURL=/cisnatural/NatLogon.html&xciParameters.natsession=' + arg1
  @frame = 'WA0'
  @session = Capybara::Session.new(:poltergeist)
  @session.visit url
end

Given(/^I press the (\d+) key$/) do |arg1|
  @session.within_frame @frame do
    @session.find(:tid, "on" + arg1.to_s).click
  end
end

Given(/^I press the multiplication key$/) do
  @session.within_frame @frame do
    @session.find(:tid, "onMul").click
  end
end

Given(/^I press the division key$/) do
  @session.within_frame @frame do
    @session.find(:tid, "onDiv").click
  end
end

Given(/^I press the equals key$/) do
  @session.within_frame @frame do
    @session.find(:tid, "onCalc").click
  end
end

Then(/^the result field should contain (\d+)$/) do |arg1|
  @session.within_frame @frame do
    expect(@session.find(:tid, "result").value).to eq arg1.to_s
  end
end



