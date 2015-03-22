require 'rails_helper'

feature "UserAccounts", :type => :feature do
  describe "Logging in" do
    let(:user) { create(:user, { password: "SuperSecret" }) }

    it "allows users to log in" do
      visit root_path
      expect(page).to have_content "Log in"

      click_link "Log in"

      fill_in "Email"   , with: user.email
      fill_in "Password", with: "SuperSecret"

      click_button "Log in"

      expect(page).to have_content "You have logged in successfully."
    end
  end

  describe "Registering" do
    it "allows users to log in" do
      visit root_path
      expect(page).to have_content "Register"

      click_link "Register"

      expect {
        fill_in "Email"                , with: "sample@example.com"
        fill_in "Password"             , with: "SuperSecret"
        fill_in "Password confirmation", with: "SuperSecret"

        click_button "Register"
      }.to change { User.count }.by 1

      expect(page).to have_content "Welcome! You have registered successfully."
    end
  end

  describe "Logging out" do
    let(:user) { create(:user) }
    before     { login_as(user, scope: :user) }

    it "allows logged in user log out" do
      visit root_path

      expect(page).to have_content "Logout"

      click_on "Logout"

      expect(page).to have_content "You have logged out successfully."
    end
  end
end
