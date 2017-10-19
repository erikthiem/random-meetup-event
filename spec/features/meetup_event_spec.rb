require 'rails_helper'

RSpec.feature 'Display meetup event', type: :feature do
  scenario 'user sees a meetup event on homepage' do
    visit '/'
    expect(page).to have_text('Random Event')
  end
end
