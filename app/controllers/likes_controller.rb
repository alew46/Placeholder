class LikesController < ApplicationController

    def create
      @bookmark = Bookmark.find(params[:bookmark_id])
      @topic = @bookmark.topic
      like = current_user.likes.build( bookmark_id: @bookmark.id )

      if like.save
        flash[:notice] = "Bookmark successfully liked!"
        redirect_to @bookmark.topic
      else
        flash[:alert] = "Something went wrong when liking. Please try again."
        redirect_to @bookmark.topic
      end
    end

    def destroy
      @bookmark = Bookmark.find(params[:bookmark_id])
      @topic = @bookmark.topic
      like = current_user.likes.find_by( bookmark_id: @bookmark.id )

      if like.destroy
        flash[:notice] = "Bookmark successfully unliked!"
        redirect_to @bookmark.topic
      else
        flash[:alert] = "Something went wrong when unliking. Please try again."
        redirect_to @bookmark.topic
      end
    end


end
