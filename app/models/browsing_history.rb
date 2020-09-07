class BrowsingHistory < ApplicationRecord

	belongs_to :user
	belongs_to :post

end
