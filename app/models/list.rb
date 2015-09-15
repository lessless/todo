class List < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :permissions
  has_many :collaborators,  through: :permissions, source: :user

  validates_presence_of :author_id

  def created_by?(user)
    author_id == user.id
  end
end
