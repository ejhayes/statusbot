class Activity < ActiveRecord::Base
  enum status: [ :pending, :completed ]

  belongs_to :user
end
