module DataBrowser
  class DataBrowserController < ::ActionController::Base
    layout "data_browser"
    protect_from_forgery :secret => Time.now.to_i.to_s
    before_filter :load_models, :authenticate

    include DataBrowser::Helpers

    # all the work here is being done by :load_models
    def index; end
    def new; end
    def edit; end

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
      redirect_to data_browser_home_url()
    end

    def destroy
      current_object.delete_all(current_object.attributes)
      flash[:notice] = "#{current_model.table_name} #{@obj.to_param} successfuly deleted!"
      redirect_to data_browser_model_url(:model => current_model_id)
    end

    def update
      current_model.update_all(data_from_params, current_object.attributes)
      flash[:notice] = "#{current_model.table_name} #{@obj.to_param} successfuly saved!"
      redirect_to data_browser_model_url(:model => current_model_id)
    end

    def create
      current_model.create(data_from_params)
      flash[:notice] = "#{current_model.table_name} #{current_object.to_param || "record"} successfuly saved!"
      redirect_to data_browser_model_url(:model => current_model_id)
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

    private

    def data_from_params
      pos = ActionController::RecordIdentifier.singular_class_name(current_model)
              current_model.new(params[pos]).attributes # Hum... well, you know..
    end
  end
end
