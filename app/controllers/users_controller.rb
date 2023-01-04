class UsersController < ApplicationController

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
        redirect_to new_user_path, notice: "登録しました！"
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
    set_user
  end

  def edit
    set_user
  end

  def update
    set_user
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
end
