module V1
  class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      if user
        render json: user, status: :created
      else
        render nothing: true, status: :bad_request
      end
    end

    private

    def user
      @_user ||= fetch_or_create_user
    end

    def fetch_or_create_user
      if github_auth_code
        find_or_create_user_from_github
      elsif token
        User.find_by(token: token)
      end
    end

    def find_or_create_user_from_github
      github_authenticator = GithubAuthenticator.new(github_auth_code)
      user_factory = UserFactory.new(github_authenticator)
      user_factory.find_or_create_user
    end

    def token
      @_token ||= session_params[:token]
    end

    def github_auth_code
      @_github_auth_code ||= session_params[:'github-auth-code']
    end

    def session_params
      params.permit(:'github-auth-code', :token)
    end
  end
end
