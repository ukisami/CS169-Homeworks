Feature: Search Movie
  In order to look at the movie they want
  Customers should be able to 
  search movie by title at all times

  Scenario: Search for inception
    Given I am on /search
    When I fill in "movie[title]" with "inception"
    And I press "Search"
    Then I should be on /movies/search_movies
    And I should see "Inception"

  Scenario: Select the movie "Inception"
    Given I searched for "inception"
    When I follow "Inception"
    Then I should be on /movies/new
    And I should have the following query string:
      | id | 27205 |
    And I should see "Title"
    And I should see "Description"
    And I should see "Rating"
    And I should see "Released on"

  Scenario: Select "None of These"
    Given I searched for "inception"
    When I follow "None of these"
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
    Given I got to the creation page for "Inception"
    When I press "Create"
    Then I should be on the show page for "Inception"
    And I should see "Title"
    And I should see "Description"
    And I should see "Rating"
    And I should see "Released on"
    And I should see "Inception"

