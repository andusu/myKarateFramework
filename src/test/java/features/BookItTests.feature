Feature: BookIt API Tests
  Background:
    * def baseUrl = 'http://cybertek-reservation-api-qa.herokuapp.com'
    #point another feature file
    * def AuthFeature = call read('classpath:features/BookItAuth.feature')
    * def accessToken = AuthFeature.token
    * print 'Token From Background', accessToken

Scenario: get user information
  Given url baseUrl
  And path 'api/users/me'
  And header Authorization = 'Bearer ' + accessToken
  And header Accept = 'application/json'
  When method GET
  Then status 200
  And print response
  And match response == {"firstName": "Ase","lastName": "Norval","role": "student-team-leader","id": 139}

@wip
Scenario: get campus information
  Given url baseUrl
  And path 'api/campuses'
  And header Authorization = 'Bearer ' + accessToken
  And header Accept = 'application/json'
  When method Get
  Then status 200
  And print response
#read the campuses.json file in the data directory
  And def expectedCampuses = read('classpath:data/campuses.json')
  And match response == expectedCampuses


