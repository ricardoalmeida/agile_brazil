require 'spec/spec_helper'
 
describe AcceptReviewersController do
  integrate_views

  it_should_require_login_for_actions :show

  before(:each) do
    @user = Factory(:user)
    @reviewer = Factory(:reviewer, :user => @user)
    Reviewer.stubs(:find).returns(@reviewer)
    activate_authlogic    
    UserSession.create(@user)
  end

  it "show action should render show template" do
    get :show, :reviewer_id => @reviewer.id
    response.should render_template(:show)
  end
  
  it "show action should populate preferences for each track when empty" do
    get :show, :reviewer_id => @reviewer.id
    assigns[:reviewer].preferences.size.should == Track.count
  end

  it "show action should keep preferences when already present" do
    @reviewer.preferences.build(:track_id => Track.first.id)
    get :show, :reviewer_id => @reviewer.id
    assigns[:reviewer].preferences.size.should == 1
  end
end
