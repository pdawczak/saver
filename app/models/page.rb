class Page < ActiveRecord::Base
  belongs_to :user

  validates :user, :title, presence: true
  validates :url, presence:   true,
                  format:     { with: URI.regexp },
                  uniqueness: { scope: :user }
end
