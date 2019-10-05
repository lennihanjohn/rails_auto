# == Schema Information
#
# Table name: bookings
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  is_active   :boolean
#  repair_date :date
#  start_at    :datetime
#  end_at      :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Booking < ApplicationRecord
    belongs_to :user
    has_one :auto_history
    accepts_nested_attributes_for :auto_history

    def self.search(search)
        self.where("repair_date like ?", "%#{search}%" )
    end

end
