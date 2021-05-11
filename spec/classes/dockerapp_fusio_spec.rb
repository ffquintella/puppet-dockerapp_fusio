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
      it { is_expected.to contain_file('/srv/application-data/fusio') }
      it { is_expected.to contain_file('/srv/application-data/fusio/public') }
      it { is_expected.to contain_file('/srv/application-data/fusio/public/apps') }
      it { is_expected.to contain_file('/srv/application-data/fusio/public/customphp') }
      it { is_expected.to contain_file('/srv/scripts/fusio') }

    end
  end
end
