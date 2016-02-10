require 'spec_helper'

feature 'creating links' do
  scenario 'user adds links and they are stored' do
    visit'/link/add-new'
    # click_button'add link'
    fill_in 'url', with: 'www.url.co.uk'
    fill_in 'title', with: 'title'
    click_button'create link'
    expect(current_path).to eq '/link'

    within 'ul#links' do
      expect(page).to have_content('title')
    end
  end
end
