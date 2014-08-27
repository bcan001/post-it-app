class Post < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	# polymorphic association:
	has_many :votes, as: :voteable

	validates :title, presence: true, length: {minimum: 2}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: true
end