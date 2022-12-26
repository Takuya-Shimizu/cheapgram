class BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end

  def index
    @blogs = Blog.all
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to new_blog_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    set_blog
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    set_blog
  end

  def update
    set_blog
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    set_blog
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end