# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :sub_id, :user_id, presence: true
  
  belongs_to :author,
    foreign_key: :user_id,
    class_name: "User"
    
  belongs_to :sub,
    foreign_key: :sub_id,
    class_name: "Sub"
    
  has_many :subs,
    foreign_key: :sub_id,
    class_name: "Sub"
end
