class User < ActiveRecord::Base
  belongs_to :last_activity, :class_name => "Activity"
end
