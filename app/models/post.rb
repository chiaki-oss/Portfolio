class Post < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	belongs_to :prefecture
	has_many :post_tags, dependent: :destroy
	has_many :tags, through: :post_tags
	has_many :post_comments, dependent: :destroy

	attachment :image

	validates :title, presence: true

    # いいね いいねしてるかどうかの確認
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

	# 通知
	has_many :notifications, dependent: :destroy
	# いいね通知
	def create_notification_like!(current_user)
		notification = current_user.active_notifications.new(
			post_id: id,
			visited_id: user_id,
			action: 'like'
		)
		notification.save if notification.valid?
	end

	# コメント通知
	def create_notification_post_comment!(current_user, post_comment_id)
		notification = current_user.active_notifications.new(
			post_id: id,
			post_comment_id: post_comment_id,
			visited_id: user_id,
			action: 'post_comment'
		)
		notification.save if notification.valid?
	end

end
