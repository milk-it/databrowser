module DataBrowser
  class DataBrowserController < ActionController::Base
    layout "data_browser"
    protect_from_forgery
    before_filter :load_models, :authenticate
    before_filter :load_current_model, :except => [:index]

    @@models = nil
    
    # all the work here is being done by :load_models
    def index; end

    def browse
      params[:select] ||= @model.column_names
      @objects = @model.find(:all,
        :conditions => params[:conditions],
        :select => params[:select] ? params[:select].join(", ") : nil
      )

      respond_to do |format|
        format.html
        format.js
      end
    end

    def empty
      @model.delete_all
      flash[:notice] = "#{@model.to_s} model was emptied"
      redirect_to :action => "index"
    end

    def new
      @obj = @model.new
    end

    def edit
      @obj = @model.find(params[:id])
    end

    def destroy
      @obj = @model.find(params[:id])
      @obj.destroy()
      flash[:notice] = "#{@model.to_s} #{@obj.to_param} successfuly deleted!"
      redirect_to :action => "browse", :model => @model.to_s
    end

    def update
      @obj = @model.find(params[:id])
      @obj.attributes = params[@model.to_s.underscore]

      @obj.save(false)
      flash[:notice] = "#{@model.to_s} #{@obj.to_param} successfuly saved!"
      redirect_to :action => "browse", :model => @model.to_s
    end

    def create
      @obj = @model.new(params[@model.to_s.underscore])
    
      @obj.save(false)
      flash[:notice] = "#{@model.to_s} #{@obj.to_param} successfuly saved!"
      redirect_to :action => "browse", :model => @model.to_s
    end

    protected

    def load_models
      # this will make that the models won't be fetched in every request
      if DataBrowser.models.size == 0
        models_root = File.join(RAILS_ROOT, "app", "models", "*.rb")
        models = Dir.glob(models_root).collect do |c|
          c = File.basename(c).gsub(/\.rb/, "").classify
          c = Kernel.const_get(c)
          c if c < ActiveRecord::Base
        end
        DataBrowser.models = models.compact
      end

      @models = DataBrowser.models
    end

    def load_current_model
      @model = Kernel.const_get(params[:model]) if params[:model]
    end

    def authenticate
      if DataBrowser::should_auth && DataBrowser::check_digest(session[:databrowser])
        authenticate_or_request_with_http_basic("DataBrowser") do |user, pass|
          session[:databrowser] = DataBrowser::auth(user, pass)
        end
      end
    end
  end
end
