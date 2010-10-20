Feature: Search Movie
  In order to look at the movie they want
  Customers should be able to 
  search movie by title at all times

  Scenario: Search for inception
    Given I am on /search
    When I fill in "movie[title]" with "inception"
    And I press "Search"
    Then I should be on /movies/search_movies
    And I should see 5 movies
    And I should see "Inception"

  Scenario: Select the movie "Inception"
    Given I searched for "inception"
    When I follow "Inception"
    Then I should be on /new
    And I should have the following query string:
      | id | 27205 |
    And I should see "Title"
    And I should see "Description"
    And I should see "Rating"
    And I should see "Released on"

  Scenario: Select "None of These"
    Given I searched for "inception"
    When I pick "None of these"
    Then I should be on /search
    And I should see "Movies not found"

  Scenario: Search for movie that cannot be found
    Given I am on /search
    When I fill in "movie[title]" with "asdfg"
    And I press "Search"
    Given I searched for "asdf"
    Then I should be on /search
    And I should see "Movies not found"

  Scenario: Confirm movie creation
    Given I am on the creation page for "Inception"
    When I click create
    Then I should be on /movies
    And I should see "Inception"

