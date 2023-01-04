class FeedsController < ApplicationController

  def index
    @feeds = Feed.all
  end

  def show
    set_feed
  end

  def new
    @feed = Feed.new
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  def edit
    set_feed
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @feed.save
          FeedMailer.feed_mail(@feed).deliver
          format.html { redirect_to feed_url(@feed), notice: "投稿しました！" }
          format.json { render :show, status: :created, location: @feed }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    set_feed
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to feed_url(@feed), notice: "投稿を更新しました！" }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_feed
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "投稿を削除しました！" }
      format.json { head :no_content }
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:id, :image, :image_cache, :title, :content, :email)
  end
end