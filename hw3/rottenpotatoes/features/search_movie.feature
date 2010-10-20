Feature: Search Movie
  In order to look at the movie they want
  Customers should be able to 
  search movie by title at all times

  Scenario: Search a movie
    Given there are more than 5 movies with the same title
    And I have input a title
    When I press the search button
    Then I should see 5 movies listed

  Scenario: Pick a movie
    Given there are results returned from search
    When I pick a movie
    Then movie information should be shown

  Scenario: No interesting movies
    Given there are results returned from search
    When I pick "None of these"
    Then new results should be returned

  Scenario: Save a movie
    Given I am prompted
    When I click on "OK"
    Then the current movie should be saved

  Scenario: Movie not found
    Given I search for a movie
    When no results are returned 
    Then I can still enter another title
    And I see a message saying "Movie not found"

