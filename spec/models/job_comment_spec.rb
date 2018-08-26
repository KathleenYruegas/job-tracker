require 'rails_helper'

describe JobComment, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without content" do
        comment = JobComment.new()
        expect(comment).to be_invalid
      end
    end
  end
end
