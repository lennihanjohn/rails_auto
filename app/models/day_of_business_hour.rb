# == Schema Information
#
# Table name: day_of_business_hours
#
#  id             :bigint           not null, primary key
#  day_of_week_id :bigint
#  open_at        :time
#  close_at       :time
#  is_overlap     :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class DayOfBusinessHour < ApplicationRecord
    belongs_to :day_of_week
end
