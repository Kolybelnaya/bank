class Request < ActiveRecord::Base
  include AASM

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

  def send_notification
    puts 'asdasdasd'
    ClientsMailer.request_accepted(self).deliver
  end
end
