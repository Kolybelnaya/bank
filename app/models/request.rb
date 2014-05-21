class Request < ActiveRecord::Base
  include AASM

  after_create :set_time

  validates :date, :time, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  belongs_to :operator, class_name: 'User'

  scope :by_date, ->(date) { where(date: date)}

  aasm do
    state :added, :initial => true
    state :accepted, after_enter: :send_notification

    event :accept do
      transitions :from => :added, :to => :accepted
    end

    event :return do
      transitions :from => :accepted, :to => :added
    end
  end

  def set_time
    update_attribute(:time, time - Time.now.in_time_zone('Moscow').utc_offset )
  end

  def send_notification
      ClientsMailer.request_accepted(self).deliver
  end
end
