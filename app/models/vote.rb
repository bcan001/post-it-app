class Vote < ActiveRecord::Base
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

	# polymorphic association (looks for voteable_type and voteable_id)
	belongs_to :voteable, polymorphic: true

	# people can only vote once on a post
	validates_uniqueness_of :creator, scope: :voteable
	
end