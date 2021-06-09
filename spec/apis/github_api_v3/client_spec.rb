require 'rails_helper'

RSpec.describe GithubAPI::V3::Client do
  describe 'api call,' do
    let :client_mock do
      mock_response = instance_double(Faraday::Response, status: 200)
      faraday_connection_mock = instance_double(Faraday::Connection, public_send: mock_response)

      allow_any_instance_of(GithubAPI::V3::Client).to receive(:client).and_return(faraday_connection_mock)
      allow_any_instance_of(GithubAPI::V3::Client).to receive(:parse_json).and_return(@expected_repo_hash)

      GithubAPI::V3::Client.new
    end

    describe '#project_repo_for' do
      it 'returns the repos for the given user' do
        @expected_repo_hash = [{'name' => 'repo_name_1'}]

        github_client = client_mock
        user_repo = github_client.project_repo_for('redferret', 'repo_name_1')

        expect(user_repo).to be_an Array
        expect(user_repo).to eq @expected_repo_hash
      end
    end

    describe '#user_commits' do
      it 'returns the commits for the given user on a repo'
    end

    describe '#user_names' do
      it 'returns the names of users on repo'
    end

    describe '#user_prs' do
      it 'returns prs for the given user'
    end
  end
end