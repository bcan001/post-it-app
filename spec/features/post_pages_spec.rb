require 'spec_helper'

describe "New Post" do

	subject { page }

  describe "New Post Page" do
  	before { visit '/users/new' }

    it { should have_selector('title', :text => "post" ) }
    it { should_not have_selector('title', :text => '| Home') }

  end

end