class Planning < ApplicationRecord
  belongs_to :daily_plan
  belongs_to :user
end
