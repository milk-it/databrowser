::ActionController::Routing::RouteSet::Mapper.send(:include, DataBrowser::Routing)
DataBrowser::DataBrowserController.prepend_view_path(File.join(File.dirname(File.expand_path(__FILE__)), "views"))
