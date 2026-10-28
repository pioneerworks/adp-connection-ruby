require 'spec_helper'
require 'rspec'


describe Adp::Connection::ClientCredentialConnection do

  it 'should initialize ClientCredentialConnection' do
    expect(Adp::Connection::ClientCredentialConnection.new).not_to be nil
  end

  it 'does not write the client secret to STDOUT on a token request' do
    config = Adp::Connection::ClientCredentialConfiguration.new(
      "clientID" => "fake-client-id",
      "clientSecret" => "fake-client-secret",
      "sslCertPath" => StringIO.new("fake-cert"),
      "sslKeyPath" => StringIO.new("fake-key"),
      "tokenServerURL" => "https://example.test/auth/oauth/v2/token"
    )
    response = double(body: '{"access_token":"fake-token","token_type":"Bearer","expires_in":3600}')
    allow(Net::HTTP).to receive(:new).and_return(instance_spy(Net::HTTP, request: response))
    allow(OpenSSL::X509::Certificate).to receive(:new)
    allow(OpenSSL::PKey::RSA).to receive(:new)

    expect { described_class.new(config).connect }
      .not_to output(/fake-client-secret/).to_stdout_from_any_process
  end
end
