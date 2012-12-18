require 'spec_helper'

describe "Imports" do
  it "should create new imports and then show them" do
    visit new_import_path
    fill_in "URL", :with => "http://www.youtube.com/watch?v=hUhxq4g3sVA"
    click_button "Submit"
    page.should have_content "http://www.youtube.com/watch?v=hUhxq4g3sVA"
    Import.last.status.should == "Pending"
  end
  it "should be able to read the latest pending videos" do
    pending "not sure how to test this"
    FactoryGirl.create(:import, :url => "http://youtube2")
    FactoryGirl.create(:import, :url => "http://youtube1")
    Import.get_latest_pending_urls(imports_path).should == ["http://youtube1","http://youtube2"]
  end
  it "should let the user delete pending imports from the index page" do
    FactoryGirl.create(:import, :url => "http://youtube")
    visit imports_path
    click_link "delete"
    page.should_not have_content "http://youtube"
  end
  it "should mark things completed after downloading" do
    @import = FactoryGirl.create(:import)
    visit "/completed?url=#{@import.url}"
    Import.last.status.should == "Completed"
    visit imports_path
    page.should_not have_content @import.url
  end
end
