class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.page params[:page]
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find(@post.user_id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if @post.user_id == current_user.id
    else
      redirect_to "/posts"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
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
    if @post.user_id == current_user.id
        respond_to do |format|
        
          if @post.update(post_params)
            format.html { redirect_to @post, notice: 'Post was successfully updated.' }
            format.json { render :show, status: :ok, location: @post }
          else
            format.html { render :edit }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
    else
      redirect_to "/posts"
      flash[:alert] = "無効なユーザー"
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.user_id == current_user.id
        @post.destroy
        redirect_back(fallback_location: root_path)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:memo, :video, :genre, :music).merge(user_id: current_user.id)
    end
end
