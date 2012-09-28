RSpec.configure do |c|
  c.before :suite do
    # This should wrap the setup stuff in acceptance, configuring masters
    # and agents
    acceptance_host_setup
  end

  c.after :suite do
    acceptance_host_teardown
  end
end
