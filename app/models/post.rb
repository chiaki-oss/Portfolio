class Post < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	belongs_to :prefecture
	has_many :post_tags
	has_many :tags, through: :post_tags

	attachment :image

	# タグ保存メソッド
	def save_tags(savepost_tags)
		savepost_tags.each do |new_name|
			post_tag = Tag.find_or_create_by(name: new_name)
			self.tags << post_tag
		end
	end

end
