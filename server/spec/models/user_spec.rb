require 'rails_helper'
# rails g rspec:model User

RSpec.describe User, type: :model do
  describe "validates" do
    describe "first name" do
      it "requires a first name" do
        user = FactoryBot.build(:user, first_name: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:first_name))
      end
    end
    describe "last name" do
      it "requires a last name" do
        user = FactoryBot.build(:user, last_name: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:last_name))
      end
    end
    describe "email" do
      it "requires a email" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:email))
      end
      it 'email is unique' do
        persisted_user= FactoryBot.create(:user)
        user=FactoryBot.build(:user, email: persisted_user.email)
        user.valid?
        expect(user.errors.messages).to(have_key(:email))
      end
    end
  end
  context "full_name check" do
    it "returns full name from first and last names and capitalizes it" do
      user = FactoryBot.build(:user, first_name: "john", last_name: "doe")
      expect(user.full_name).to(eq("John Doe"))
    end
  end
end