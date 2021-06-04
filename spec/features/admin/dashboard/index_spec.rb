require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  it 'has a header indicating admin dashboard, column titles' do
    visit '/admin/dashboard'
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content("Top Customers")
  end

  it 'has link to admin dashboard' do
    visit '/admin/dashboard'
    expect(page).to have_link('Dashboard')
    click_on('Dashboard')
    expect(current_path).to eq("/admin/dashboard")
  end

  it 'has link to admin merchants items index' do
    visit '/admin/dashboard'
    expect(page).to have_link('Merchants')
    click_on('Merchants')
    expect(current_path).to eq("/admin/merchants")
  end

  it 'has link to admin invoices index' do
    visit '/admin/dashboard'
    expect(page).to have_link('Invoices')
    click_on('Invoices')
    expect(current_path).to eq("/admin/invoices")
  end
end
