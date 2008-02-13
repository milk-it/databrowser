with_options :controller => "data_browser/data_browser" do |db|
  db.connect "/databrowser"
  db.connect "/databrowser/:model", :action => "browse"
  db.connect "/databrowser/:model/:action"
  db.connect "/databrowser/:model/:id/:action"
end
