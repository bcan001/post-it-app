class Post < ActiveRecord::Base

	include Voteable
	include Sluggable

	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	# polymorphic association:
	
	
	validates :title, presence: true, length: {minimum: 2}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: true

	
	sluggable_column :title
	# after_validation :generate_slug
	#see activerecord callbacks for more info


	# sent all methods to .rb file in lib/voteable.rb foler


end