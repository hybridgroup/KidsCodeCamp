require 'spec_helper'

describe "About Tools Lessons pages", type: :feature, focus: true do
  let!(:about){ create(:editpage, id: 1) }
  let!(:tools){ create(:editpage, id: 2) }
  let!(:lessons){ create(:editpage, id: 3) }

  it "shows About page" do
    visit about_path
    
    page.should have_content('About')
    page.should have_content(about.content)
  end

  it "shows Tools page" do
    visit tools_path
    
    page.should have_content('Tools')
    page.should have_content(tools.content)
  end

  it "shows Lessons page" do
    visit lessons_path
    
    page.should have_content('Lessons')
    page.should have_content(lessons.content)
  end
end