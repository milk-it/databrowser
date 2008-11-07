Gem::Specification.new do |s|
  s.name = "databrowser"
  s.version = "1.0.1"
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carlos Junior"]
  s.date = "2008-08-06"
  s.description = "Rails DataBrowser helps you in development providing an easy to use interface to access your database. This can be also used in production mode, as an interface to your data."
  s.email = ["carlos@milk-it.net"]
  s.extra_rdoc_files = ["README", "MIT-LICENSE"]
  s.files = [
    "README", "Rakefile", "MIT-LICENSE", "install.rb", "uninstall.rb",
    "lib/data_browser.rb", "lib/data_browser/data_browser.rb", "lib/data_browser/data_browser_controller.rb",
    "lib/data_browser/routing.rb", "lib/data_browser/helpers.rb",
    "lib/data_browser/views/data_browser/data_browser/about.html.erb",
    "lib/data_browser/views/data_browser/data_browser/browse.html.erb",
    "lib/data_browser/views/data_browser/data_browser/browse.js.rjs",
    "lib/data_browser/views/data_browser/data_browser/edit.html.erb",
    "lib/data_browser/views/data_browser/data_browser/_form.html.erb",
    "lib/data_browser/views/data_browser/data_browser/index.html.erb",
    "lib/data_browser/views/data_browser/data_browser/new.html.erb",
    "lib/data_browser/views/data_browser/data_browser/_obj.rhtml",
    "lib/data_browser/views/layouts/data_browser.html.erb"
  ]
  s.has_rdoc = false
  s.homepage = "http://redmine.milk-it.net/projects"
  s.post_install_message = %q{
Access http://redmine.milk-it.net/projects to learn how to use DataBrowser.
It's simple as add 2 lines in your routes.rb!
}
  s.rdoc_options = []
  s.require_paths = ["lib"]
  s.rubyforge_project = "databrowser"
  s.rubygems_version = "1.1.1"
  s.summary = "Rails DataBrowser helps you in development providing an easy to use interface to access your database. This can be also used in production mode, as an interface to your data."
  s.test_files = ["test/databrowser_test.rb"]

  s.add_dependency("rails", [">= 2.0"])
end
