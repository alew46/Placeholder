class BookmarksController < ApplicationController

  before_action :set_topic

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = @topic.bookmarks.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark added to #{@bookmark.topic}!"
      redirect_to @topic
    else
      flash[:alert] = "There was a problem adding this bookmark."
      redirect_to @topic
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:notice] = "Bookmark deleted!"
      redirect_to @topic
    else
      flash[:alert] = "Unable to delete bookmark. Please try again."
      redirect_to @topic
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
