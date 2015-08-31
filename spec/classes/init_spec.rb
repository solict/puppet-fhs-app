require 'spec_helper'
describe 'fhs_app' do

  context 'with defaults for all parameters' do
    it { should contain_class('fhs_app') }
  end
end
