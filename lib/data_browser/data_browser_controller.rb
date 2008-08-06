module DataBrowser
  class DataBrowserController < ::ActionController::Base
    layout "data_browser"
    protect_from_forgery :secret => Time.now.to_i.to_s
    before_filter :load_models, :authenticate

    helper_method :current_model, :current_model_id

    # all the work here is being done by :load_models
    def index; end

    def browse
      params[:select] ||= current_model.column_names
      @objects = current_model.find(:all,
        :conditions => params[:conditions],
        :select => params[:select] ? params[:select].join(", ") : nil
      )

      respond_to do |format|
        format.html
        format.js
      end
    end

    def empty
      current_model.delete_all
      flash[:notice] = "#{current_model.table_name} model was emptied"
      redirect_to :action => "index"
    end

    def new
      @obj = current_model.new
    end

    def edit
      @obj = current_model.find(params[:id])
    end

    def destroy
      @obj = current_model.find(params[:id])
      @obj.destroy()
      flash[:notice] = "#{current_model.table_name} #{@obj.to_param} successfuly deleted!"
      redirect_to :action => "browse", :model => current_model_id
    end

    def update
      @obj = current_model.find(params[:id])
      @obj.update_attributes(params[current_model.to_s.underscore])

      flash[:notice] = "#{current_model.table_name} #{@obj.to_param} successfuly saved!"
      redirect_to :action => "browse", :model => current_model_id
    end

    def create
      @obj = current_model.new(params[current_model.to_s.underscore])
    
      @obj.save(false)
      flash[:notice] = "#{current_model.table_name} #{@obj.to_param} successfuly saved!"
      redirect_to :action => "browse", :model => current_model_id
    end

    protected

    def load_models
      if DataBrowser.models.size == 0
        (DataBrowser.tables.empty?? ActiveRecord::Base.connection.tables : DataBrowser.tables).each do |table|
          model_name = "DataBrowser::#{table.classify}"
          eval("#{model_name} = Class.new(ActiveRecord::Base); DataBrowser.models.push(#{model_name})")
        end
      end

      @models = DataBrowser.models
    end

    def authenticate
      if DataBrowser::should_auth && !DataBrowser::check_digest(session[:databrowser])
        authenticate_or_request_with_http_basic("DataBrowser") do |user, pass|
          session[:databrowser] = DataBrowser::auth(user, pass)
        end
      end
    end

    def current_model
      @model ||= DataBrowser.models[current_model_id] if current_model_id
    end

    def current_model_id
      params[:model].to_i if params[:model]
    end
  end
end
