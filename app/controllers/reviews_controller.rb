class ReviewsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  def index
    @review = Review.all
  end

  def show
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    Review.create(create_params)
    @book = Book.find(params[:book_id])
  end

  def edit
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.update(create_params)
    end
  end

  def destroy
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.destroy
    end
  end
  private
  def create_params
    return params.require(:review).permit(:rate,:text).merge(book_id: params[:book_id],user_id: current_user.id)
  end
end
