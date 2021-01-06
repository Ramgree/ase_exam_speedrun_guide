Feature: Rating
  As a customer
  I want to rate a product that I bought
  So I go to the ratings app
  To rate it

  Scenario: Rating list
    Given that I love "haskell"
    And I go to the ratings list
    Then I can see what other people rated it

  Scenario: Rating a product
    Given that I love "haskell"
    And I go to the ratings list
    Then I click "rate haskell"
    And I write my email "bruno98@ut.ee" and rating "5"
    Then I should get a confirmation message
