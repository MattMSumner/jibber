require "rails_helper"

describe GithubAuthenticator do
  describe "#name" do
    it "returns the github name from github" do
      stub_github_auth(access_token: "expected")
      stub_octokit(access_token: "expected", user: "user")
      auth = GithubAuthenticator.new("auth_code")

      expect(auth.name).to eq "user"
    end
  end

  def stub_github_auth(access_token: "token", scope: "scope", token_type: "token_type")
    stub_request(:post, "https://github.com/login/oauth/access_token").
      with(body: {
        "client_id" => ENV["GITHUB_KEY"],
        "client_secret" => ENV["GITHUB_SECRET"],
        "code" => "auth_code"
      }).to_return(
        status: 200,
        body: {
          access_token: access_token,
          scope: scope,
          token_type: token_type
        }.to_json
      )
  end

  def stub_octokit(access_token:, user:)
    client = double(:client, user: { login: user } )
    allow(Octokit::Client).to receive(:new).with(access_token: access_token).
      and_return(client)
  end
end
