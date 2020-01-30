class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :attended_event, class_name: 'Event', foreign_key: 'event_id'
  validates :attendee_id, presence: true
  validates :attended_event_id, presence: true

  def accept
    self.update(attending: true)
  end

  def decline
    self.update(attending: false)
  end
end
