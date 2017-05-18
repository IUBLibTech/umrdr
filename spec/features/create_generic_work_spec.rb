# Generated via
#  `rails generate curation_concerns:work GenericWork`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a GenericWork' do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      login_as user
    end

    scenario do
      visit new_hyrax_generic_work_path
      fill_in 'Title', with: 'Test GenericWork'
      fill_in 'Creator', with: 'Creator, Test'
      fill_in 'Method', with: 'Test'
      fill_in 'Description', with: 'Test'
      choose 'generic_work_rights_httpcreativecommonsorgpublicdomainzero10'
      select 'Other', from: 'generic_work_subject'
      click_button 'Publish'
      expect(page).to have_content 'Test GenericWork'
      expect(page).to have_content 'Creator, Test'
    end
  end
end
