class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password
  # attr_accessible :title, :body
end