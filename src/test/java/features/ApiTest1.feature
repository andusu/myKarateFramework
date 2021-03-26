Feature: exchange rate api tests

  Scenario: basic test with status code validation
    Given url 'https://api.exchangeratesapi.io/latest'
    When method GET
    Then status 200

  Scenario: get rates for specific day
    Given url 'https://api.exchangeratesapi.io/2010-01-12'
    When method get
    Then status 200

  Scenario: header verification
    Given url 'https://api.exchangeratesapi.io/2010-01-12'
    When method get
    Then status 200
    And match header Content-Type == 'application/json'
    And match header Vary == 'Accept-Encoding'
    And match header Connection == 'keep-alive'
    #to verify headers we use header keyword then headerName without double or single code
    And match header Date == '#present'
    #this equals to headers().hasHeaderWithName("headername") in restAssured

  @wip
  Scenario: json body verification
    Given url 'https://api.exchangeratesapi.io/2010-01-12'
    When method get
    Then status 200
    And match header Content-Type == 'application/json'
    And print response.base
    #verify base is EUR
    And match response.base == 'EUR'
    And print response.rates.USD


  