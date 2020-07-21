class Post < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	belongs_to :prefecture
	has_many :post_tags
end
