require 'rails_helper'

feature "AccessTheApp", :type => :feature do
  it "welcomes with the message" do
    visit root_path
    expect(page).to have_content "Welcome in Saver!"
  end
end
