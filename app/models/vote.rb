class Vote < ActiveRecord::Base
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

	# polymorphic association (looks for voteable_type and voteable_id)
	belongs_to :voteable, polymorphic: true


	# people can only vote once on a post
	# creator means only 1 user can vote only 1 time
	# scope means the validation checks that the SAME user can't vote on the SAME object
	validates_uniqueness_of :creator, scope: [:voteable_id, :voteable_type]

end