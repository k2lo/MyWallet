class PagesController < ApplicationController
	def info
		@setting = Setting.find_by(user_id: current_user.id)
	end
end