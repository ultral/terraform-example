require 'spec_helper'

describe file('/usr/sbin/terraform') do
  it { should be_file }
  it { should be_mode '755' }
end
