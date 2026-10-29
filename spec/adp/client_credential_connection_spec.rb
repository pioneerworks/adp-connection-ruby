require 'spec_helper'
require 'rspec'


describe Adp::Connection::ClientCredentialConnection do

  it 'should initialize ClientCredentialConnection' do
    expect(Adp::Connection::ClientCredentialConnection.new).not_to be nil
  end
end
