require "rails_helper"

describe UserFactory do
  describe "#find_or_create_by" do
    it "calls find_or_create_by on User" do
      authenticator = double(:authenticator, name: "name")
      allow(User).to receive(:find_or_create_by)
      user_factory = UserFactory.new(authenticator)

      user_factory.find_or_create_user

      expect(User).to have_received(:find_or_create_by).with(name: "name")
    end
  end
end
