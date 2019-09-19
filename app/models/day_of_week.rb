# == Schema Information
#
# Table name: day_of_weeks
#
#  id          :bigint           not null, primary key
#  day_of_week :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DayOfWeek < ApplicationRecord
    has_one :day_of_business_hour
end
