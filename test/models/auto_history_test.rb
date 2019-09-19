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

require 'test_helper'

class AutoHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
