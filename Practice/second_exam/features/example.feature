Feature: Bowling
  As a bowling afficionado
  Covid caused all bowling alleys to close
  So I go to the Bowling app
  to play it

  Scenario: Playing a game
    Given that my username is "jenkins" and I want to play Bowling
    Then I go to the start page
    And input my username
    And I play ten games
    Then when I finish I should see my score
