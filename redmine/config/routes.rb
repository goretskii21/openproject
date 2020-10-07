ActionController::Routing::Routes.draw do |map|
  map.connect '', :controller => "welcome"
  map.connect 'roles/workflow/:id/:role_id/:tracker_id', :controller => 'roles', :action => 'workflow'
  map.connect 'help/:ctrl/:page', :controller => 'help'
  map.connect ':controller/:action/:id/:sort_key/:sort_order'
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect ':controller/:action/:id'
end
