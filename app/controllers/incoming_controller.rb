class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    # You put the message-splitting and business
    # magic here.

     # Find the user by using params[:sender]
     # Check if user is nil, if so, create and save a new user
     @user = User.create_with(password: 'changeme').find_or_create_by(email: params[:sender])

     # Find the topic by using params[:subject]
     # Check if the topic is nil, if so, create and save a new topic
     @topic = Topic.create_with(user_id: @user).find_or_create_by(title: params[:subject])

     # Assign the url to a variable after retreiving it from params["body-plain"]
     @email_url = params["body-plain"]

     # Now that you're sure you have a valid user and topic, build and save a new bookmark
     @bookmark = @topic.bookmarks.create(url: @email_url)

    # Assuming all went well.
    head 200
  end
end
