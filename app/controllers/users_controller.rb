class UsersController < ApplicationController
  
  before_action :user_find_by?, only: [:show, :edit, :update]
	before_action :authenticate_user!
  before_action :new_kara, only: [:show, :index]
  before_action :user_check, only: [:edit, :update]
  
  def show
    @books = Book.where(user_id: @user.id)
  end
  
  def edit
  end
  
  def index
    @users = User.all
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private
  
  def user_check
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to user_path(current_user.id)
    end
  end
  
  def user_find_by?
  	@user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end
