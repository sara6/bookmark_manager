require 'spec_helper'

  def signup(email: 'mo@mo.co.uk',
            password: 'oranges!',
            password_confirmation: 'oranges!')
    visit '/signup'
    # expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button'register'
  end

  feature 'user sign up' do

    scenario 'i can sign up' do
      expect { signup }.to change(User, :count).by(1)
      expect(page).to have_content('Welcome, mo@mo.co.uk')
      expect(User.first.email).to eq('mo@mo.co.uk')
    end

    scenario 'passwords do not match' do
      expect {signup(password_confirmation: 'wrong') }.not_to change(User, :count)
      expect(page).to have_current_path('/signup')
      expect(page).to have_content('Password does not match the confirmation')
    end

    scenario 'user does not enter an email' do
      expect { signup(email: nil) }.not_to change(User, :count)
      expect(current_path).to eq('/signup')
      expect(page).to have_content('Email must not be blank')
    end

    scenario 'genuine email address is entered' do
      expect{signup(email: 'lalala.com')}.not_to change(User, :count)
      expect(current_path).to eq('/signup')
      expect(page).to have_content('Email has an invalid format')
    end

    scenario 'a user cannot sign up with an already registered email address' do
      signup
      expect{signup}.not_to change(User, :count)
      expect(page).to have_content('Email is already taken')
    end
  end



  feature 'User sign in' do

    let!(:user) do
      User.create(email: 'user@example.com',
                  password: 'secret1234',
                  password_confirmation: 'secret1234')
    end

    scenario 'with correct credentials' do
      sign_in(email: user.email, password: user.password)
      p current_url
      expect(page).to have_content "Welcome, #{user.email}"
    end

    def sign_in(email:, password:)
      visit '/signin'
      fill_in :email, with: email
      fill_in :password, with: password
      click_button 'Sign in'
    end

  end
