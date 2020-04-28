require 'rails_helper'

describe 'Customers controller', :type => :feature do
  before :each do
    Customer.create!(email: 'user@example.com', password: 'password', name_firstname: 'User name', name_lastname: 'User surname', phone: '608944804', personal_data_agreement: true, terms_agreement: true)
  end

  it 'signs customer in' do
    visit new_customer_session_path
    within('#new_customer') do
      fill_in 'customer[email]', with: 'user@example.com'
      fill_in 'customer[password]', with: 'password'
    end
    click_button 'Přihlásit'
    expect(page).to have_content 'Přihlášení bylo úspěšné.'
  end
end