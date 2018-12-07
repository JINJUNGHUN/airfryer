class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  # GET /posts
  # GET /posts.json

  def like_toggle
    like = Lkie.find_by(user_id: current_user.id, post_id: params[:post_id])
    if like.nil? # 좋아요가 없다면?
      Like.create(user_id: current_user.id, post_id: params[:post_id])
    else # 좋아요가 있다면?
      like.destroy
    end
    redirect_to posts_url
  end

  def index
    @posts = Post.all
    @posts = Post.order('created_at DESC').page params[:page]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post_attachments = @post.post_attachments.all
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post_attachment = @post.post_attachments.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        params[:post_attachments]['image'].each do |a|
          @post_attachment = @post.post_attachments.create!(:image => a, :post_id => @post.id)
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:likes, :category_id, :image_cache, :remove_image, :image, :title, :description, :temperature, :time, ingredients_attributes:[:id, :content, :_destroy], steps_attributes:[:id, :direction, :_destroy], post_attachments_attributes: [:id, :post_id, :image])
    end
end
