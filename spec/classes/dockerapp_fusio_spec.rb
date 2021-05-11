require 'spec_helper'

describe 'dockerapp_fusio' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:params) do
        {
          version: '1.4.1',
          service_name: 'fusio',
        }
      end

      it { is_expected.to compile }


    end
  end
end
