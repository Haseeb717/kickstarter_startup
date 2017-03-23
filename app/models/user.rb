class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  
  ratyrate_rater
  acts_as_liker
  
  has_many :products
  has_many :back_products
  has_many :report_products

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image, :content_type => { :content_type => /\Aimage/ }, :size => { :in => 0..5.megabytes }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.uid+"@facebook.com"
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation! 
      user.save!
    end
  end

  def self.from_google_omnioauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation! 
      user.save!
    end
  end
  
end
