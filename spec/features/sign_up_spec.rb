
require "spec_helper"

RSpec.feature "User signs up", type: :feature do
  before do
    Candidate.delete_all
  end

  scenario "and is added to the roster" do
    visit root_path

    fill_in "Name", with: "Mickey Mouse"
    fill_in "Experience", with: "Junior"
    click_button "Sign Me Up!"

    expect(page).to have_text("Mickey Mouse")
    expect(page).to have_text("Junior")
  end

  scenario "and the current number of signups is displayed" do
    Candidate.create!(name: "Person One", experience: "Junior")
    Candidate.create!(name: "Person Two", experience: "Senior")

    visit root_path

    expect(page).to have_text("2 candidates")
  end

  scenario "and doesn't submit a name" do
    visit root_path

    fill_in "Experience", with: "Junior"
    click_button "Sign Me Up!"

    expect(page).to have_text("Name can't be blank")
  end
end
