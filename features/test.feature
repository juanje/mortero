Feature: Test the environment
  In order to know if this works
  As a developer
  I want to provision the VM

  Background: Vagrant project with a single VM
    Given a vagrant project in "."
    #And with the output actived
    And the config loaded
    And a single VM named "base" created
    And having the VM "base" running

  Scenario: Test the LWRP with a recipe
    Given a LWRP named "conf"
    And a "plain_file" recipe with the code:
    """
    conf_plain_file '/vagrant/tmp/text.txt' do
      new_line  'Hello world'
      action    :append
    end
    """
    When I do a vagrant provision
    Then the exit status should not be 1
    And the file "tmp/text.txt" should contain "Hello world"
