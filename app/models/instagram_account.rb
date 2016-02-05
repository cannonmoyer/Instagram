class InstagramAccount < ActiveRecord::Base
	has_many :follows, dependent: :destroy
	
end
