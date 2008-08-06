module DataBrowser
  module Helpers
    def self.included(base)
      base.send :helper_method, :current_model, :current_object, :current_model_id, :object_params
    end

    def current_model
      @model ||= DataBrowser.models[current_model_id] if current_model_id
    end

    def current_object
      @obj ||= if params[:id] && !params[:id].eql?("x")
        current_model.find(params[:id])
      elsif params[:object]
        current_model.first :conditions => params[:object]
      else
        current_model.new
      end
    end

    def current_model_id
      params[:model].to_i if params[:model]
    end

    def object_params(object)
      params = {:model => current_model_id}
      if object.to_param
        params[:id] = object.to_param
      else
        params[:id] = "x"
        params[:object] = object.attributes
      end
      params
    end
  end
end
