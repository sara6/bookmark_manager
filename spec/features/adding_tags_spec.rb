require 'spec_helper'

feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit'/link/add-new'
    # click_button'add link'
    fill_in 'url', with: 'www.url.co.uk'
    fill_in 'title', with: 'title'
    fill_in 'tags', with: 'education'
    click_button 'create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

  scenario 'I can add multiple tags to a new link' do
    visit '/link/add-new'
    fill_in 'url', with: 'http://www.makersacamdey.com'
    fill_in 'title', with: 'Makers Acamdey'
    fill_in 'tags', with: 'education ruby'
    click_button 'create link'
    link= Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

end
