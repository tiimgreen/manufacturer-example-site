class ProductReviewsController < ApplicationController
  before_action :authenticate_user!, only: %w( index destroy )

  def index
    @reviews = ProductReview.all
  end

  def new
    @review = ProductReview.new
  end

  def create
    @product = Product.find(params[:id])

    @review = @product.product_reviews.build(product_review_params)

    if @review.save
      flash[:success] = 'Review added'
      redirect_to @product
    else
      flash[:warning] = 'Error adding review'
      redirect_to @product
    end
  end

  def destroy
    @product = Product.find(params[:product_id])

    if ProductReview.find(params[:review_id]).destroy
      redirect_to @product
      flash[:success] = 'Reivew successfully deleted'
    else
      redirect_to @product
      flash[:warning] = 'Problem deleting Review'
    end
  end

  private

    def product_review_params
      params.require(:product_review).permit(:name, :body, :rating)
    end
end
