class BlogArticlesController < ApplicationController
  before_action :authenticate_user!, only: %w( new create edit update destroy )

  def new
    @blog_article = BlogArticle.new
  end

  def create
    @blog_article = BlogArticle.new(
      blog_article_params.merge({ author_id: current_user.id, is_published: false })
    )

    if @blog_article.save
      flash[:success] = 'Blog Article created'
      redirect_to blog_path
    else
      render :new
    end
  end

  def index
    @page_title = 'Blog'

    if user_signed_in?
      @blog_articles = BlogArticle.all.order('created_at desc')
    else
      @blog_articles = BlogArticle.all.where(is_published: true).order('created_at desc')
    end
  end

  def show
    @blog_article = BlogArticle.find(params[:id])

    render_404 if !@blog_article.is_published && !user_signed_in?

    @page_title = "#{@blog_article.title} - Blog"
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        space_after_headers: true,
                                        fenced_code_blocks: true,
                                        prettify: true)

    @sidebar_blog_articles = BlogArticle.where(is_published: true).last(3).reverse

    @breadcrumb_components.last[:name] = @blog_article.title
  end

  def edit
    @blog_article = BlogArticle.find(params[:id])
    @page_title = @blog_article.title

    @breadcrumb_components[2][:name] = @blog_article.title
  end

  def update
    @blog_article = BlogArticle.find(params[:id])

    if @blog_article.update_attributes(blog_article_params)
      flash[:success] = 'Blog Article updated'
      redirect_to blog_article_path @blog_article
    else
      render :edit
    end
  end

  def destroy
  end

  def publish
    @blog_article = BlogArticle.find(params[:id])
    @blog_article.is_published = true

    if @blog_article.save
      flash[:success] = 'Article published'
    else
      flash[:warning] = 'Error publishing Article'
    end

    redirect_to request.referrer
  end

  def unpublish
    @blog_article = BlogArticle.find(params[:id])
    @blog_article.is_published = false

    if @blog_article.save
      flash[:success] = 'Article Unpublished'
    else
      flash[:warning] = 'Error unpublishing Article'
    end

    redirect_to request.referrer
  end

  private

    def blog_article_params
      params.require(:blog_article).permit(:title, :body, :short_description,
                                           :image)
    end
end
