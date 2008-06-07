require 'data_browser/data_browser'
require 'data_browser/data_browser_controller'
require 'data_browser/routing'

::ActionController::Routing::RouteSet::Mapper.send(:include, DataBrowser::Routing)
DataBrowser::DataBrowserController.prepend_view_path(File.join(File.dirname(File.expand_path(__FILE__)), "data_browser", "views"))
