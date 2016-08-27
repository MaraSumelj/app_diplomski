class PagesController < ApplicationController
	before_action :admin_user, only: [:edit, :destroy, :new, :create]
	before_action :logged_in_user, only: [:show, :index]
  def index
  	@pages = Page.paginate(page: params[:page])
  end

  def new
  	@page=Page.new
  end

  def create
	@page = Page.new(page_params)
	if @page.save
		flash[:success] = "You successfuly created new page!"
		redirect_to @page
	else
		render 'new'
	end
  end

  def show
  	@page = Page.find(params[:id])
  end

  def edit
  	@page = Page.find(params[:id])
  end

  def update
	@page = Page.find(params[:id])
	if @page.update_attributes(page_params)
		flash[:success] = "Page updated"
		redirect_to @page
	else
		render 'edit'
	end
  end

  def destroy
	Page.find(params[:id]).destroy
	flash[:success] = "Page deleted"
	redirect_to pages_url
  end

  private
	def page_params
		params.require(:page).permit(:name, :description)
	end

	
end
