class Post < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	belongs_to :prefecture
	has_many :post_tags, dependent: :destroy
	has_many :tags, through: :post_tags

	attachment :image

    # いいね
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	# タグ保存メソッド
	def save_tags(savepost_tags)
		current_tags = self.tags.pluck(:name) unless self.tags.nil?
		old_tags = current_tags - savepost_tags
		new_tags = savepost_tags - current_tags

		# 古いタグの削除
		old_tags.each do |old_name|
			self.tags.delete Tag.find_by(name: old_name)
		end

		#新しいタグ追加
		new_tags.each do |new_name|
			# find_or_create_byメソッド(該当データで保存or新規作成)
			# '#'は含めないで保存
			post_tag = Tag.find_or_create_by(name: new_name.delete('#'))
			# ↓＝self.tags.push(post_tag)：配列の要素を追加
			self.tags << post_tag
		end
	end

end
