class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %w( index show )

  def index
    @products = Product.all
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        space_after_headers: true,
                                        fenced_code_blocks: true,
                                        prettify: true)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params.merge({ user_id: current_user.id }))

    if @product.save
      flash[:success] = 'Product saved'
      redirect_to product_path @product
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = ProductReview.new
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        space_after_headers: true,
                                        fenced_code_blocks: true,
                                        prettify: true)

    @breadcrumb_components.last[:name] = @product.name
  end

  def edit
    @product = Product.find(params[:id])

    @breadcrumb_components[-2][:name] = @product.name
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params.merge({ user_id: current_user.id }))
      flash[:success] = 'Product updated'
      redirect_to product_path @product
    else
      render :edit
    end
  end

  def destroy
  end

  def new_specification
    @product = Product.find(params[:id])
    @product_specification = ProductSpecification.new
  end

  def create_specification
    @product = Product.find(params[:id])
    @product_specification = ProductSpecification.new(
      product_specification_params.merge({ product_id: @product.id }))

    if @product_specification.save
      flash[:success] = 'Specification added'
      redirect_to product_path @product
    else
      render :new
    end
  end

  def edit_specification
    @product = Product.find(params[:product_id])
    @product_specification = ProductSpecification.find(params[:specification_id])

    # Edit Breadbrumb Section
    @breadcrumb_components.last[:name] = "Edit #{@product_specification.key}"
    @breadcrumb_components[2][:name] = @product.name
    @breadcrumb_components.delete_at(-3)
    @breadcrumb_components.delete_at(-2)
  end

  def update_specification
    @product = Product.find(params[:product_id])
    @product_specification = ProductSpecification.find(params[:specification_id])

    if @product_specification.update_attributes(product_specification_params)
      flash[:success] = 'Specification updated'
      redirect_to product_path @product
    else
      render :edit_specification
    end
  end

  def index_specification
    @product = Product.find(params[:id])
  end

  def destroy_specification
  end

  def new_image
    @product = Product.find(params[:id])
    @product_image = ProductImage.new
  end

  def create_image
    @product = Product.find(params[:id])

    @image = @product.product_images.build(product_image_params)

    if @image.save
      flash[:success] = 'Image created'
      redirect_to product_path @product
    else
      render :new_image
    end
  end

  def edit_image
    @product = Product.find(params[:product_id])
    @product_image = ProductImage.find(params[:image_id])
  end

  def update_image
    @product = Product.find(params[:product_id])
    @product_image = ProductImage.find(params[:image_id])

    if @product_image.update_attributes(product_image_params)
      flash[:success] = 'Image updated'
      redirect_to product_path @product
    else
      render :edit_image
    end
  end

  def destroy_image
    @product = Product.find(params[:product_id])
    @product_image = ProductImage.find(params[:image_id])

    @product_image.destroy

    redirect_to request.referrer
  end

  private

    def product_params
      params.require(:product).permit(:name, :introduction, :description,
                                      :specification)
    end

    def product_specification_params
      params.require(:product_specification).permit(:key, :value)
    end

    def product_image_params
      params.require(:product_image).permit(:alt_text, :image)
    end
end
