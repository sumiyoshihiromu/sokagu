class Post < ApplicationRecord
	validates :content, {presence: true, length: {maximum: 140}}
	validates :user_id, {presence: true}
	validates :post_image, {presence: true}
	
	has_many :bookmarks, dependent: :destroy
	
	def user
    return User.find_by(id: self.user_id)
	end
  
  
end
