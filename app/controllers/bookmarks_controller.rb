class BookmarksController < ApplicationController

  before_action :set_topic, except: [ :destroy ]

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = @topic.bookmarks.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark added to #{@bookmark.topic.title}!"
      redirect_to @bookmark.topic
    else
      flash[:alert] = "There was a problem adding this bookmark."
      redirect_to @bookmark.topic
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Bookmark deleted!"
      redirect_to @bookmark.topic
    else
      flash[:alert] = "Unable to delete bookmark. Please try again."
      redirect_to @bookmark.topic
    end
  end

  def get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
