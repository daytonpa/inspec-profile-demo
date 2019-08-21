# encoding: utf-8
# copyright: 2018, The Authors

title 'node-exporter-default'

control 'node-exporter-default-group-1.0.1' do
  impact 1.0
  title 'Creates a system group for the node_exporter service'
  describe group('node_exporter') do
    it { should exist }
    its('gid') { should be < 1000 }
  end
end

control 'node-exporter-default-user-1.0.1' do
  impact 1.0
  title 'Creates a system user for the node_exporter service'
  describe user('node_exporter') do
    it { should exist }
    its('group') { should eq 'node_exporter' }
    its('home') { should cmp '/home/node_exporter' }
    its('uid') { should be < 1000 }
  end
end

control 'node-exporter-default-directory-logs-1.0.1' do
  impact 1.0
  title 'Creates a directory for the node_exporter service logs'
  describe directory('/var/log/node_exporter') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'node_exporter' }
    its('group') { should cmp 'node_exporter' }
    its('mode') { should cmp '0755' }
  end
end

control 'node-exporter-default-file-logs-main-1.0.1' do
  impact 1.0
  title 'Creates a primary log file for the node_exporter service'
  describe file('/var/log/node_exporter/node_exporter.logs') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'node_exporter' }
    its('group') { should cmp 'node_exporter' }
    its('mode') { should cmp '0644' }
  end
end

control 'node-exporter-default-file-logs-error-1.0.1' do
  impact 1.0
  title 'Creates an error log file for the node_exporter service'
  describe file('/var/log/node_exporter/node_exporter.error') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'node_exporter' }
    its('group') { should cmp 'node_exporter' }
    its('mode') { should cmp '0644' }
  end
end

control 'node-exporter-default-file-pid-1.0.1' do
  impact 1.0
  title 'Creates a PID file for the node_exporter service'
  describe file('/var/run/node_exporter.pid') do
    it { should exist }
    its('owner') { should cmp 'node_exporter' }
    its('group') { should cmp 'node_exporter' }
    its('mode') { should cmp '0644' }
  end
end

control 'node-exporter-default-file-daemon-1.0.1' do
  if os.name == 'ubuntu'
    daemon_file_path = '/etc/systemd/system/node_exporter.service'
  elsif os.name == 'amazon' 
    if os.release == '2'
      daemon_file_path = '/etc/systemd/system/node_exporter.service'
    else
      daemon_file_path = '/etc/rc.d/init.d/node_exporter'
    end
  end
  impact 1.0
  title 'Creates a daemon file for the node_exporter service'
  describe file(daemon_file_path) do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'node_exporter' }
    its('group') { should cmp 'node_exporter' }
  end
end

control 'node-exporter-default-version-1.0.1' do
  impact 1.0
  title 'Installs the desired version of the node_exporter service'
  describe command('/usr/bin/node_exporter --version 2>&1') do
    its('stdout') { should match(/version 0.18.1/) }
    its('exit_status') { should eq 0 }
  end
end

control 'node-exporter-default-service-1.0.1' do
  impact 1.0
  title 'Starts and enables the node_exporter service'
  describe service('node_exporter') do
    it { should be_installed }
    it { should be_running }
    it { should be_enabled }
  end
end
