class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5} # this validation only fires when you create a user (don't want to have to make a new password when updating)
end