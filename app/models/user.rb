class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event'
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, through: :attendances

  def upcoming_events
    self.created_events.where('date >= ?', Time.now).order(date: :asc)
  end

  def previous_events 
    self.created_events.where('date < ?', Time.now).order(date: :desc)
  end
end
