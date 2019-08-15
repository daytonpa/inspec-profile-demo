# encoding: utf-8
# copyright: 2018, The Authors

title 'default'

# you add controls here
control 'node-exporter-config-pid-1.0.1' do                       # A unique ID for this control
  impact 1.0                                                      # The criticality, if this control fails.
  title 'Create a PID file for the node_exporter.service daemon'  # A human-readable title
  describe file('/var/run/node_exporter.pid') do                  # The actual test
    it { should exist }
  end
end