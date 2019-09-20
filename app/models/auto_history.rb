# == Schema Information
#
# Table name: auto_histories
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  vehicle_id :bigint
#  desc       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AutoHistory < ApplicationRecord
    has_many :auto_history_types
    belongs_to :vehicle
end
