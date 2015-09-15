class User < ActiveRecord::Base
  has_many :permissions
  has_many :lists, through: :permissions
end
