class Subscriber < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	validates :email, format: /@/
	validates :subject, presence: true
	validates :message, presence: true

end
