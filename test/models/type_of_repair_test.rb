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

require 'test_helper'

class TypeOfRepairTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
