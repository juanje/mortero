Before { @dirs = ['.'] }

# Background
Given /^a vagrant project in "([^"]*)"$/ do |path|
  @opts = {:cwd => path}
end

And /^with the output actived$/ do
  @opts[:ui_class] = Vagrant::UI::Colored
end

And /^the config loaded$/ do
  @vagrant_env = Vagrant::Environment.new(@opts)
end

And /^a single VM named "([^"]*)" created$/ do |name|
  @vm = @vagrant_env.vms[:default]
  @vm.box.name.should be == name and @vm.created?.should be true
end

And /^having the VM "([^"]*)" running$/ do |name|
  @vm.box.name.should be == name and @vm.state.should be == :running
end

# Scenarios
Given /^a LWRP named "([^"]*)"$/ do |lwrp|
  @lwrp = lwrp
  File.should be_directory("cookbooks/#{@lwrp}")
end

And /^a "([^"]*)" recipe with the code:$/ do |recipe, code|
  @vm.config.vm.provisioners.first.config.run_list = ["recipe[#{recipe}]"]

  test_cookbook = "cookbooks/#{recipe}"
  FileUtils.rm_rf(test_cookbook) if File.directory?(test_cookbook)
  FileUtils.cp_r("templates/cookbook", test_cookbook)
  open("#{test_cookbook}/recipes/default.rb", "w") { |f| f << code }
  open("#{test_cookbook}/metadata.rb", "a") { |f| f << %(depends "#{@lwrp}"\n) }
end

When /^I do a vagrant provision$/ do
  FileUtils.rm_rf('tmp') if File.directory?('tmp')
  Dir.mkdir('tmp')

  @vagrant_env.cli(['provision'])
end

And /^running "([^"]*)" with vagrant I get "([^"]*)"$/ do |cmd,expected_output|
  @aruba_timeout_seconds = 8
  steps %{
    When I run `vagrant ssh -c "#{cmd}" -- -l vagrant`
    Then the output should contain "#{expected_output}"
  }
end
