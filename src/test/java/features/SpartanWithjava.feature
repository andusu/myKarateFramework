Feature: Karate Java integration

  Background:
    * def baseUrl = 'https://api.exchangeratesapi.io'
    * def spartanUrl = 'http://18.204.13.230:8000'
    * def hrUrl = 'http://34.228.41.120:1000/ords/hr/'

  Scenario: Get a spartan with request header
    Given url spartanUrl
    And path "/api/spartans"
    And header Accept = 'application/json'
    When method GET
    Then status 200

  Scenario: Create a new Spartan
    Given url spartanUrl
    And path "/api/spartans/"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
  """
  {
        "name": "Alalalala",
        "gender": "Female",
        "phone": 1231231234
  }
  """
    When method POST
    Then status 201
    And print response

  Scenario: reading Java methods
  #point the class that we want to run
  #Java.type --> used to connect to Java class
    * def SDG = Java.type('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    * print newSpartan
  #run the static method in that class and capture the result
  #the return map object is represented as a Json

  Scenario: Create a spartan with Random Data (JAVA)
    * def SDG = Java.type('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    Given url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request newSpartan
    When method POST
    Then status 201
    And print response
    And match response.success == "A Spartan is Born!"
    #verify names
    And match response.data.name == newSpartan.name
    And def idToDelete = response.data.id
    Given url spartanUrl
    And path 'api/spartans'
    And path idToDelete
    When method DELETE
    Then status 204


