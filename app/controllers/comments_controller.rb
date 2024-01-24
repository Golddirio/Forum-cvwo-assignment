class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /comments or /comments.json
  def index
    @tags = Tag.all

    ta = params[:ta]

    if !ta.nil?
      @comments = Comment.where(tag_id: ta)
    else
      @comments = Comment.all
    end  
  end


  # GET /comments/1 or /comments/1.json


  def search
    @comments = Comment.where("comment LIKE?", "%" + params[:q] + "%")
  end



  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
   # @comment = Comment.new
    @comment = current_user.comments.build
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    #@comment = Comment.create(comment_params)
     @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
     #@comment = Comment.find(params[:id]
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    #@comment = Comment.find(params[:id]
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to comments_path, notice: "Not Authorised To Edit OR Destroy It!!" if @comment.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:first_name, :last_name, :comment, :tag_id, :user_id)
    end
end
