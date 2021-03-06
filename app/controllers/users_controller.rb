class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
  	@users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
	@user = User.new(user_params)
	if @user.save
		flash[:success] = "Welcome to the Funda!"
		log_in @user
		remember @user
		redirect_to @user
	else
		render 'new'
	end
  end

  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User deleted"
	redirect_to users_url
  end

  def edit
	@user = User.find(params[:id])
  end

  def update
	@user = User.find(params[:id])
	if @user.update_attributes(user_params)
		flash[:success] = "Profile updated"
		redirect_to @user
	else
		render 'edit'
	end
  end

  private
	def user_params
		params.require(:user).permit(:name, :email, :password,:password_confirmation)
	end

end
