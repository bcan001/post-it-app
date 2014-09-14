class User < ActiveRecord::Base
	include Sluggable
	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5} # this validation only fires when you create a user (don't want to have to make a new password when updating)

	#before_save :generate_slug!

	# every time it will pull up the username in the URL
  
	sluggable_column :username


	def admin?
		self.role == 'admin'
	end

	def moderator?
		self.role == 'moderator?'
	end

end