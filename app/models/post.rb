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

	before_save :generate_slug!
	# after_validation :generate_slug
	#see activerecord callbacks for more info

	def total_votes
		up_votes - down_votes
	end

	def up_votes
		self.votes.where(vote: true).size
	end

	def down_votes
		self.votes.where(vote: false).size
	end

	def to_param
		self.slug
	end

	# slug for title in post db table ("what we want to replace","replace with...")
	def generate_slug!
		the_slug = to_slug(self.title)
		post = Post.find_by slug: the_slug
		count = 2
		while post && post != self
			the_slug = append_suffix(the_slug)
			post = Post.find_by slug: the_slug
			count += 1
		end
		self.slug = str.downcase
	end

	def append_suffix(str, count)
		if str.split('-').last.to_i != 0
			return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
		else
			return str + "-" + count.to_s
		end
	end

	def to_slug(name)
		str = name.strip
		str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
		str.gsub! /-+/,"-"
		str.downcase
	end
end