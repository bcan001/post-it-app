class Comment < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	belongs_to :post

	# polymorphic association:
	has_many :votes, as: :voteable

	validates :body, presence: true
end