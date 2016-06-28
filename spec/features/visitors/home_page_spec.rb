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
    expect(page).to have_content  "Toggle navigationIsoStampSign inIsostamp Isotopic signature transfer and mass pattern prediction (Isostamp) is an enabling technique for chemically-directed proteomics. It is an algorithm for the targeted detection and identification of modified species by mass spectrometry (MS). Isostamp Web V2 This web app enables other people to analyze their own data with Isostamp. The Isostamp project was previously hosted at mass-spec-169.herokuapp.com. Sign inContact If you come across any problems with the site, please create a Github issue with specific details and screenshots of the problem. Please direct questions about the Isostamp method to hello@isostamp.org. Interview with postdocs David Spiciarich and Christina WooallowfullscreenCopyright © Bertozzi Group 2016"
  end
end
