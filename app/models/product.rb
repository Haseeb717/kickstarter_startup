class Product < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :back_products,:dependent => :destroy
	has_many :report_products,:dependent => :destroy

	acts_as_taggable

	ratyrate_rateable "speed", "engine", "price"
	acts_as_likeable

	has_attached_file :image, styles: { small: "64x64>", large: "250x250>" }
	has_attached_file :video
	
	validates_attachment :image, presence: true, :content_type => { :content_type => /\Aimage/ }, :size => { :in => 0..5.megabytes }
  validates_attachment :video, presence: true, :content_type => { :content_type => /\Avideo/ }, :size => { :in => 0..25.megabytes }

end
