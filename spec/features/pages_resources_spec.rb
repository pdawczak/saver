require 'rails_helper'

feature "PagesResources", :type => :feature do
  let(:user) { create(:user) }

  def login_and_navigate_to_app_path
    login_as(user, scope: :user)
    visit app_path
  end

  describe "List of links" do
    let(:user_page) { build(:page, title: "Testing Page", 
                                    user: user) }

    before { user_page.save }

    it "renders list of pages of user" do
      login_and_navigate_to_app_path

      expect(page).to have_content(user_page.title)
    end
  end

  describe "Adding new page" do
    let(:page_attrs) do
      attributes_for(:page, { title:       "Ruby Weekly: A Free, Weekly Email Newsletter",
                              description: "A free, once–weekly e-mail round-up of Ruby news and articles." })
    end

    it "Allows to add new Page" do
      login_and_navigate_to_app_path

      within("#pages-list") do
        expect(page).not_to have_content page_attrs[:title]
      end

      within("#new-page") do
        fill_in "URL",         with: page_attrs[:url]
        fill_in "Title",       with: page_attrs[:title]
        fill_in "Description", with: page_attrs[:description]

        click_button "Add Page"
      end

      within("#pages-list") do
        expect(page).to have_content page_attrs[:title]
        expect(page).to have_content page_attrs[:description]
      end
    end
  end
end
