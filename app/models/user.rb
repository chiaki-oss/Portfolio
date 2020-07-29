class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  attachment :image

  validates :name, presence: true
  validates :is_active, presence: true

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: 'post'

  has_many :contacts

  #会員ステータス1＝会員のみログイン可
  def active_for_authentication?
    super && (self.is_active == true)
  end

end
