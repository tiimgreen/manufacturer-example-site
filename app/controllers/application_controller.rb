class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_page, :set_title, :set_breadcrumbs, :set_footer_blog_articles
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def set_title
      unless action_name.to_s.downcase == 'destroy'

        case params[:action]
        when 'index'
          @page_title = controller_name.titleize
        when 'show'
          @page_title = controller_name.singularize.titleize
        when 'new', 'create'
          @page_title = "New #{controller_name.singularize.titleize}"
        when 'edit', 'update'
          @page_title = "Edit #{controller_name.singularize.titleize}"
        else
          @page_title = action_name.titleize
        end
      end
    end

    def set_breadcrumbs
      path = request.env['PATH_INFO']

      @breadcrumb_components = [
        { name: 'Home', path: '/' }
      ]

      base_path = ''

      path.split('/').reject(&:empty?).each do |path|
        base_path += "/#{path}"
        @breadcrumb_components.push({ name: path.titleize, path: base_path })
      end
    end

    def set_footer_blog_articles
      @footer_blog_articles = BlogArticle.where(is_published: true).last(4).reverse
    end

    def configure_permitted_parameters
      # rubocop:disable Blocks, BlockAlignment, LineLength
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:first_name, :last_name, :email, :password,
                 :password_confirmation, :current_password, :info, :avatar)
      end
    end

    def render_404
      raise ActionController::RoutingError.new('Page Not Found')
    end

    def set_page
      @page = WebPage.find_or_create_by(key: "#{controller_name}_#{action_name}")
    end
end
