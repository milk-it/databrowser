module DataBrowser
  module Routing
    def databrowser(opts={})
      root = opts[:root] || "databrowser"
      with_options :controller => "data_browser/data_browser" do |db|
        # Databrowser pages
        db.data_browser_home    "/#{root}",       :action => "index"
        db.data_browser_about   "/#{root}/about", :action => "about"
        # Model manipulation
        db.with_options :model => /\d+/ do |model|
          model.data_browser_model  "/#{root}/:model",          :action => "browse", :conditions => {:method => :get}
          model.data_browser_new    "/#{root}/:model/new",      :action => "new",    :conditions => {:method => :get}
          model.data_browser_object "/#{root}/:model/:id",      :action => "show",   :conditions => {:method => :get}
          model.data_browser_edit   "/#{root}/:model/:id/edit", :action => "edit",   :conditions => {:method => :get}

          model.connect "/#{root}/:model",     :action => "empty",   :conditions => {:method => :delete}
          model.connect "/#{root}/:model/:id", :action => "update",  :conditions => {:method => :put}
          model.connect "/#{root}/:model/:id", :action => "destroy", :conditions => {:method => :delete}
          model.connect "/#{root}/:model",     :action => "create",  :conditions => {:method => :post}
        end
      end
    end
  end
end
