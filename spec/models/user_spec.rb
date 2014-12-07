require "rails_helper"

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "#create" do
    it "generates a token" do
      user = User.create(name: "name")

      expect(user.token.length).to eq 22
    end
  end
end
