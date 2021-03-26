Feature: Parameters examples

  Background:
    * def baseUrl = 'https://api.exchangeratesapi.io'
    * def spartanUrl = 'http://18.204.13.230:8000'
    * def hrUrl = 'http://34.228.41.120:1000/ords/hr/'


  Scenario: path parameters
    Given url baseUrl
    And path 'latest'
    When method get
    Then status 200

  Scenario: path parameters
    Given url baseUrl
    And path '2010-01-12'
    When method get
    Then status 200

  Scenario: get all spartans with path
    Given url spartanUrl
    And path '/api/spartans'
    When method get
    Then status 200
    And print response

  Scenario: get all spartans with path
    * def expectedSpartan =
  """
    {
  "gender": "Female",
  "phone": 1234567897,
  "name": "aFemale",
  "id": 10
    }
    """
    Given url spartanUrl
    And path '/api/spartans'
    And path '10'
    When method get
    Then status 200
    And print response
    And match response == expectedSpartan

  Scenario: query parameters
    Given url spartanUrl
    And path 'api/spartans/search'
    And param nameContains = 'j'
    And param gender = 'Female'
    When method GET
    Then status 200
    And match header Content-Type == 'application/json'
    And print response
    And match response.totalElement == 37
    #verify each content has gender = Female
    And match each response.content contains {"gender":"Female"}
    #second way of iteration
    And match each response.content[*].gender contains 'Female'
    And match response.content[0].name == 'Jaimie'
    #verify each content phone is number
    And match each response.content[*].phone == '#number'

  Scenario: hr regions example
    Given url hrUrl
    And path 'regions'
    When method GET
    Then status 200
    And print response
    And match response.limit == 25






