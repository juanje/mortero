Feature: Test the environment
  In order to know if this works
  As a developer
  I want to provision the VM

  Background: Vagrant project with a single VM
    Given a vagrant project in "."
    And with the output actived
    And the config loaded
    And a single VM named "base" created
    And having the VM "base" running

  @gsettings
  Scenario: Test the LWRP with a gsettings provider
    Given a LWRP named "desktop"
    And a "background" recipe with the code:
    """
    desktop_settings 'picture-uri' do
      schema   'org.gnome.desktop.background'
      type     'string'
      value    '/var/share/background/coolimage.jpg'
      user     'vagrant'
    end
    """
    When I do a vagrant provision
    Then the exit status should not be 1

  @gconf
  Scenario: Test the LWRP with a gconf provider
    Given a LWRP named "desktop"
    And a "background" recipe with the code:
    """
    key = '/desktop/gnome/background/picture_filename'
    desktop_settings key do
      type     'string'
      value    '/var/share/background/coolimage.jpg'
      user     'vagrant'
      provider 'desktop_gconf'
    end
    """
    When I do a vagrant provision
    Then the exit status should not be 1
    And running "gconftool-2 --get /desktop/gnome/background/picture_filename" with vagrant I get "/var/share/background/coolimage.jpg"
