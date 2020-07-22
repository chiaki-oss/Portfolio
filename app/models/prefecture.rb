class Prefecture < ApplicationRecord
	has_many :posts
	belongs_to :area, optional: true
end
