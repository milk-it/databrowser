module DataBrowser
  module Routing
    def databrowser(opts={})
      path = File.join(File.dirname(File.expand_path(__FILE__)), "..", "routes.rb")
      @root = opts[:root] || "databrowser"
      eval(IO.read(path))
    end
  end
end
