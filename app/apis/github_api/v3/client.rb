require_relative 'api_exceptions'

module GithubAPI
  module V3
    class Client
      include ApiExceptions

      API_ENDPOINT = 'https://api.github.com'.freeze

      attr_reader :oauth_token
      attr_reader :response

      def initialize(oauth_token = nil)
        @oauth_token = oauth_token
      end

      def project_repo
        @_repo ||= request(
          http_method: :get,
          endpoint: "/repos/redferret/little-esty-shop"
        )
      end

      def user_commits
      end

      def user_names
      end

      def user_prs
      end

      private

      def client
        # Using @_, @ scopes to the instance and _ is just to
        # distinguish the variable as protected. ||= is equivalent to X = X || Y, this is testing for falsy 
        # values. If X is falsy (nil) then Y is assigned to X. Otherwise X just receives itself. 
        # 
        # In this case @_faraday_connection will either be an instance of a Faraday::Connection or a new
        # Faraday::Connection is created, this keeps from recopening a connection each time a call is made from 
        # this client. This does not help with the Api Request Quota counter though.
        @_faraday_connection ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
          client.headers['Authorization'] = "token #{oauth_token}" if oauth_token.present?
          client.headers['Accept'] = 'application/vnd.github.v3+json'
        end
      end

      def request(http_method: :get, endpoint: nil, params: {})
        raise 'API endpoint must be defined' if endpoint.nil?
        
        @response = client.public_send(http_method, endpoint, params)
        
        return parse_json if response_successful?
        
        raise http_error, "Status: #{response.status}, Response: #{response.body}"
      end
      
      def parse_json
        # Oj is similar to JSON.parse however Oj is much faster
        Oj.load(response.body)
      end
    end
  end
end