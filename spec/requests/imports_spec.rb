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
end
