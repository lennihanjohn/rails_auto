# == Schema Information
#
# Table name: type_of_repairs
#
#  id          :bigint           not null, primary key
#  code        :string(255)
#  desc        :text(65535)
#  repair_time :integer
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TypeOfRepair < ApplicationRecord
    belongs_to :auto_history_type
end
