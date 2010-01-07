require 'spec/spec_helper'
 
describe UsersController do
  integrate_views
  
  it_should_require_logout_for_actions :new, :create
  
  before(:each) do
    Factory(:user)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    # +stubs(:valid?).returns(false)+ doesn't work here because
    # inherited_resources does +obj.errors.empty?+ to determine
    # if validation failed
    post :create, :user => {}
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end
  
  it "show action should render show template" do
    get :show, :id => User.first
    response.should render_template(:show)
  end

end
