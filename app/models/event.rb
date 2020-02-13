class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, source: :user

  validates :title, presence: true
  validates :location, presence: true
  validates :date, presence: true

  scope :upcoming_events, -> { where('date >= ?', Time.now).order(date: :asc).includes(:creator) }
  scope :previous_events, -> { where('date < ?', Time.now).order(date: :desc).includes(:creator) }
end
