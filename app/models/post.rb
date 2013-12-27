class Post < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :content, :title, :avatar
  has_many :comments
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/images/:style/test.jpg"
  validates :title,
    :presence => true,
    :length => {:maximum => 20}
  validates_attachment :avatar, presence: true,
    content_type: { content_type: ["image/jpg", "image/png"] },
    size: { less_than: 2.megabytes }
  scope :title_or_body_matches, lambda{|q|
    where 'title like :q or body like :q', :q => "%#{q}%"
  }

end