# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Welcome"
  scenario 'visit the home page' do
    visit root_path
    expect(page).to have_content "Isotopic signature transfer and mass pattern prediction (IsoStamp) is an enabling technique for chemically-directed proteomics. It is an algorithm for the targeted detection and identification of modified species by mass spectrometry (MS). This web app enables other people to analyze their own data with IsoStamp. Sign in to upload dataInterview with postdocs David Spiciarich and Christina WooallowfullscreenThe IsoStamp project was previously hosted at mass-spec-169.herokuapp.com. Copyright © Bertozzi Group 2016"
  end
end
