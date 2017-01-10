class Room < ApplicationRecord
  extend FriendlyId

  validates_presence_of :title
  validates_presence_of :slug

  friendly_id :title, use: [:slugged, :history]

  has_many :reviews , dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room
  belongs_to :user

  validates_presence_of :title, :location
  validates_length_of :description, minimum: 30, allow_blank: false

  scope :most_recent, -> { order(created_at: :desc) }

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      where(['location ILIKE :query OR
              title ILIKE :query OR
              description ILIKE :query', query: "%#{query}%"])
    else
      all
    end
  end
end
