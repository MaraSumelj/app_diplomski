class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	def create
		@micropost = Micropost.new
		@micropost.page_id = current_page_id
		@micropost = current_user.microposts.build(micropost_params)
		flash[:success] = "Micropost almost created!"
		@micropost.page_id = current_page_id
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			render 'static_pages/help'
		end
	end

	def destroy
		flash[:success] = "Micropost almost deleted"
		Micropost.find(params[:id]).destroy
		flash[:success] = "Micropost deleted"
		redirect_to root_url
	end

	private
	def micropost_params
		params.require(:micropost).permit(:content, :attachment)
	end

	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url if @micropost.nil?
	end

end
