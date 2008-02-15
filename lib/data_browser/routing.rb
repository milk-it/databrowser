module DataBrowser
  module Routing
    def databrowser()
      path = File.join(File.dirname(File.expand_path(__FILE__)), "..", "routes.rb")
      eval(IO.read(path))
    end
  end
end
