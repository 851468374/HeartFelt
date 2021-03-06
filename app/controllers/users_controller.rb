class UsersController < ApplicationController
  before_action :logged_in_user,only: [:index, :edit, :update, :destroy]
  def home
    
  end
  def show
    @user=User.find_by(id: cookies.signed[:user_id])
    @tasks=@user.tasks.paginate(page: params[:page],per_page: 10)
  end

  def edit
  @user=User.find_by(id: cookies.signed[:user_id])
  end

  def create
    @user=User.new(user_params)
     if @user.save
       redirect_to @user
     else
       render 'new'
     end
  end

  def user_params
    @params.require(:user).permit(:stuid, :authority,:password, :password_confirmation)
  end
  #确保用户正确
  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
