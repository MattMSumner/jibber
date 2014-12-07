require "rails_helper"

describe V1::SessionsController do
  describe "#new" do
    context "github-auth-code present" do
      it "authenticates via github" do
        user = double(:user)
        user_factory = double(:user_factory, find_or_create_user: user)
        github_authenticator = double(:github_authenticator)
        allow(GithubAuthenticator).to receive(:new).
          with('valid_code').
          and_return(github_authenticator)
        allow(UserFactory).to receive(:new).
          with(github_authenticator).
          and_return(user_factory)

        post :create, 'github-auth-code' => 'valid_code'

        expect(response).to have_http_status(:created)
      end
    end
  end
end
