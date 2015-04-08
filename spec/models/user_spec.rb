# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }
  subject    { user }

  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :pages }

  describe ".recent_pages" do
    it "returns pages in DESC order" do
      feb_page = user.pages.create(attributes_for(:page, created_at: DateTime.parse("2015-02-01")))
      jan_page = user.pages.create(attributes_for(:page, created_at: DateTime.parse("2015-01-01")))

      expect(user.recent_pages).to eq [feb_page, jan_page]
    end
  end
end
