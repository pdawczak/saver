# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  url         :string           not null
#  title       :string           not null
#  description :text
#  identifier  :uuid
#

require 'rails_helper'

RSpec.describe Page, :type => :model do
  let(:page) { build(:page_with_user) }
  subject    { page }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to :user        }
  it { is_expected.to respond_to :url         }
  it { is_expected.to respond_to :title       }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :identifier  }

  describe "validation" do
    context "user" do
      before { page.user = nil }
      it     { is_expected.to be_invalid }
    end

    context "url" do
      context "empty" do
        before { page.url = "" }
        it     { is_expected.to be_invalid }
      end

      context "invalid format" do
        before { page.url = "testing.com" }
        it     { is_expected.to be_invalid }
      end

      context "uniqueness" do
        let(:user)         { create(:user) }
        let(:another_user) { create(:user) }
        let(:example_url)  { "http://google.com" }

        before do
          page.user = user
          page.url  = example_url
          page.save
        end

        context "for single user" do
          it "is invalid" do
            another_page = user.pages.build(attributes_for(:page, url: example_url))
            expect(another_page).to be_invalid
          end
        end

        context "for different users" do
          it "is valid" do
            another_page = another_user.pages.build(attributes_for(:page, url: example_url))
            expect(another_page).to be_valid
          end
        end
      end
    end

    context "title" do
      before { page.title = "" }
      it     { is_expected.to be_invalid }
    end
  end

  describe ".recent" do
    before do
      @feb_page = create(:page_with_user, created_at: DateTime.parse("2015-02-01")) 
      @jan_page = create(:page_with_user, created_at: DateTime.parse("2015-01-01")) 
      @mar_page = create(:page_with_user, created_at: DateTime.parse("2015-03-01")) 
    end
     
    it "returns pages in DESC order" do
      expect(Page.recent).to eq [@mar_page, @feb_page, @jan_page]
    end

    it "returns limited amount of pages" do
      expect(Page.recent(1)).to eq [@mar_page]
    end
  end
end
