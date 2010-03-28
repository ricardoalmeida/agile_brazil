Given /^I am logged as a ([^\"]*)$/ do |role|
  @user = Factory(:user)
  @user.add_role(role)
  @reviewer = Factory(role.to_sym, :user => @user)
  Factory(:preference, :reviewer => @reviewer)
  
  visit login_path
  fill_in("user_session_username", :with => @user.username) 
  fill_in("user_session_password", :with => @user.password) 
  click_button("Log in")
  page.body.should =~ /Login efetuado com sucesso./m
end

Given /^exist the session "([^\"]*)"$/ do |title|
  author = Factory(:user)
  Factory(:session, :title => title, :author => author, :track_id => 5, :audience_level_id => 4)
end