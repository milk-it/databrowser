module DataBrowser
  module Routing
    def databrowser(args={})
      if args[:username] && args[:password]
        DataBrowser::set_user(args[:username], args[:password])
      end

      path = File.join(File.dirname(File.expand_path(__FILE__)), "..", "routes.rb")
      eval(IO.read(path))
    end
  end
end
