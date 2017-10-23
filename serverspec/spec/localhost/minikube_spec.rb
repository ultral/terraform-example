require 'spec_helper'

describe file('/usr/local/bin/minikube') do
  it { should be_file }
  it { should be_mode '755' }
end

describe file('/usr/local/bin/kubectl') do
  it { should be_file }
  it { should be_mode '755' }
end
