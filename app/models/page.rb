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

class Page < ActiveRecord::Base
  belongs_to :user

  validates :user, :title, presence: true
  validates :url, presence:   true,
                  format:     { with: URI.regexp },
                  uniqueness: { scope: :user }

  scope :recent, -> (limit = nil) do 
     order("created_at DESC")
       .limit(limit)
  end
end
