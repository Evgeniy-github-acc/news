require 'rails_helper'

feature 'administrator must authentificate' do
  let(:admin) { create(:admin) }
  background { visit admin_root_path }
  
  scenario 'user visits admin resource' do
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'admin tries to sign in with invalid params' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'administrator can sign in with valid params' do
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end
end