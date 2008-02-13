module DataBrowser
  class DataBrowserController < ActionController::Base
    layout "data_browser"
    protect_from_forgery
    before_filter :load_models

    def index
    end

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

    def new
      @obj = @model.new
    end

    def edit
      @obj = @model.find(params[:id])
    end

    def destroy
      @obj = @model.find(params[:id])

      @obj.destroy()
      flash[:notice] = "#{@model.to_s} #{@obj.send(@model.primary_key)} successfuly deleted!"
      redirect_to :action => "browse", :model => @model.to_s
    end

    def update
      @obj = @model.find(params[:id])
      @obj.attributes = params[@model.to_s.underscore]

      @obj.save(false)
      flash[:notice] = "#{@model.to_s} #{@obj.send(@model.primary_key)} successfuly saved!"
      redirect_to :action => "browse", :model => @model.to_s
    end

    def create
      @obj = @model.new(params[@model.to_s.underscore])
    
      @obj.save(false)
      flash[:notice] = "#{@model.to_s} #{@obj.send(@model.primary_key)} successfuly saved!"
      redirect_to :action => "browse", :model => @model.to_s
    end

    protected

    def load_models
      if DataBrowser::Models.size > 0
        @models = DataBrowser::Models
      else
        @models = Dir.glob(File.join(RAILS_ROOT, "app", "models", "*.rb")).collect { |class_file|
          c = Kernel.const_get(File.basename(class_file).gsub(/\.rb/, "").classify)
          c if c < ActiveRecord::Base
        }
        @models.compact!
      end

      @model = Kernel.const_get(params[:model]) if params[:model]
    end
  end
end
