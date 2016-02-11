require 'spec_helper'

  def signup
  visit '/signup'
  # expect(page.status_code).to eq(200)
  fill_in 'email', with: 'mo@mo.co.uk'
  fill_in 'password', with: 'oranges!'
  click_button'register'
  end


  feature 'user sign up' do

    scenario 'i can sign up' do
    expect { signup }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, mo@mo.co.uk')
    expect(User.first.email).to eq('mo@mo.co.uk')
  end

end
