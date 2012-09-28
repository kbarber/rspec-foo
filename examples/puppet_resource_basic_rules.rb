describe 'test puppet resource firewall command with real rules' do
  before :each do
    # This would just be a helper
    iptables_setup
  end

  agents.each do |host|
    it "test with a single simple rule on #{host}" do
      on host, puppet('resource firewall') do
        hash = if host['platform'].match /(el-5)/
          '2fe04d0e5d47207166944df84cb70850'
        else
          'c0595bf3760d4dcb41773d27b5827b5c'
        end

        stdout.should == <<-EOS
firewall { '9999 #{hash}':
  ensure      => 'present',
  action      => 'accept',
  chain       => 'INPUT',
  destination => '2.2.2.2/32',
  proto       => 'tcp',
  source      => '1.1.1.1/32',
  table       => 'filter',
}
        EOS
      end
    end
  end
end
