class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5} # this validation only fires when you create a user (don't want to have to make a new password when updating)

	before_save :generate_slug!

	# every time it will pull up the username in the URL
  def to_param
		self.slug
	end

  def generate_slug!
		the_slug = to_slug(self.username)
		user = User.find_by slug: the_slug
		count = 2
		while post && post != self
			the_slug = append_suffix(the_slug)
			user = User.find_by slug: the_slug
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