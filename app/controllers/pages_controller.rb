class PagesController < ApplicationController
	def info
		@setting = current_user.present? ? Setting.find_by(user_id: current_user.id) : nil
	end
end