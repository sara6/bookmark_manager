require 'spec_helper'

feature 'View Link' do

  before(:each) do
    Link.create(url: 'http://www.magicseaweed.com', title: 'Magic Seaweed', tags: [Tag.first_or_create(name: 'surf')])
    Link.create(url: 'http://www.makersacamdey.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])
    Link.create(url: 'http://www.bubble-bobble.com', title: 'Bubble Bobble', tags: [Tag.first_or_create(name: 'bubbles')])
  end

  # scenario 'go to homepage and see a list of link' do
  #   Link.create(url: 'http://www.bookmark.com', title: 'Favorite link')
  #
  #   visit '/link'
  #   expect(page.status_code).to eq 200
  #
  #    within 'ul#link' do
  #     expect(page).to have_content('Favorite link')
  #    end
  # end
  scenario 'I can filter links by tag' do

    visit '/tags/bubbles'
    expect(page.status_code).to eq(200)
    within 'ul#links' do
      expect(page).not_to have_content('Magic Seaweed')
      expect(page).not_to have_content('Makers Academy')
      expect(page).to have_content('Bubble Bobble')
    end

  end

end
