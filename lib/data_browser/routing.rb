module DataBrowser
  module Routing
    def databrowser(opts={})
      root = opts[:root] || "databrowser"
      with_options :controller => "data_browser/data_browser" do |db|
        db.connect "/#{root}"
        db.connect "/#{root}/about", :action => "about"
        db.connect "/#{root}/:model", :action => "browse"
        db.connect "/#{root}/:model/:action"
        db.connect "/#{root}/:model/:id/:action"
      end
    end
  end
end
