class DiscussionsController < ApplicationController

  def show
    discussion_id = params[:id]
    @root_discussion = Discussion.get_root_post(discussion_id)
    @discussions_with_replies = Discussion.get_post_replies(@root_discussion[:id])
  end

  def index
    @discussions = Discussion.get_root_posts
  end

  def new

  end

  def create
    # TODO
    discussion = params[:discussion]
    root_id = -1
    if discussion.has_key? :root_discussion_id
      root_id = discussion[:root_discussion_id]
    end
    Discussion.create!(:title => discussion[:title], :body => discussion[:body], :author => discussion[:author], :root_discussion_id => root_id)
    redirect_to discussions_path
  end

  def edit
    # TODO
  end

  def update
    # TODO
  end

  def destroy
    # TODO
  end

end
