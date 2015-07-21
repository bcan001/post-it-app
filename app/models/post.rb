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



	if Rails.env.development?
  	has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default_image1.jpg"
  else
	  has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default_image1.jpg",
									  	:storage => :dropbox,
									    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
									    :path => ":style/:id_:filename"
	end
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_attachment_presence :image
end