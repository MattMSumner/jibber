require "rails_helper"

describe V1::SessionsController do
  describe "#create" do
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

    context "token present" do
      it "fetches the user" do
        user = double(:user)
        allow(User).to receive(:find_by).with(token: "token").and_return(user)

        post :create, token: :token

        expect(response).to have_http_status(:created)
      end
    end

    context "invalid params present" do
      it "returns bad_request" do
        post :create

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
