Feature: Manage current allocation
  In order to track and effectively spend my time
  As a user
  I want to allocate myself some time to do some task

  Scenario: See I have no allocation
    Given I have no current allocation
    When I go to the current allocation page
    Then I should see 'What are you going to do?'
    And I should not see 'You are doing'

  Scenario: See my current allocation
    Given I have current allocation to task Programming in the next 3 hours
    When I go to the current allocation page
    Then I should see 'You are doing'
    And I should see 'Programming' in '#current-task-title'
    And Element '#current-task-time' should have attribute 'data-time-remaining'
    And I should see 'Remaining'
    And I should see '3:00:00' in '#current-task-time'

  Scenario: See overdue allocation
    Given I have current allocation to task Programming elapsed 2 hours ago
    When I go to the current allocation page
    Then I should see 'You are doing'
    And I should see 'Programming' in '#current-task-title'
    And Element '#current-task-time' should have attribute 'data-time-overdue'
    And I should see 'Overdue'
    And I should see '2:00:00' in '#current-task-time'

