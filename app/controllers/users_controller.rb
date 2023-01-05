class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :own_user, only: [:edit, :update]
  skip_before_action :login_required, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:back]
      render :new
    else
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user.id), notice: "登録しました！"
      else
        render :new
      end
    end
  end

  def confirm
    @user = User.new(user_params)
    render :new if @user.invalid?
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :image, :image_cache, :name, :email, :password, :password_confirmation)
  end

  def own_user
    unless current_user == User.find(params[:id])
      redirect_to feeds_path
    end
  end
end