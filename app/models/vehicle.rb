# == Schema Information
#
# Table name: vehicles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  make       :string(255)
#  model      :string(255)
#  color      :string(255)
#  year       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vehicle < ApplicationRecord
    has_many :auto_histories
    belongs_to :user
end