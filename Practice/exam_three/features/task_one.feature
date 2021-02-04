Feature: Buying Something

  Scenario: Searching for a product
    When I open the app
    Given that the following products are in the database
      | name        |  unit   |  quantity   |
      | headphones  |  1.0    |    1        |
      | headset     |  3.0    |    3        |
      | pants       |  1.0    |    1        |
    And I am registered with email "stress@ut.ee", PIN "666666" and balance "600"
    Then I go to the "search" page
    And type in "head"
    And given that my user balance is bigger than "0"
    And I click "Submit"
    Then I am taken to a form for "headphones"
    And I type my email and pin
    When I click "Submit"
    Then I am shown a message "headphones, 1.0, 599"