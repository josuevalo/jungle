require 'rails_helper'

RSpec.feature "Visitor can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see a in cart number increment by 1" do
    visit root_path

    # find('img', match: :first).click
    click_button 'Add', match: :first
    sleep 5
    # commented out b/c it's for debugging only
    save_and_open_screenshot

    expect(page).to have_text "My Cart (1)"
  end




end
