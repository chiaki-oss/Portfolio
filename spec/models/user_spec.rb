require 'rails_helper'

RSpec.describe User, type: :model do
	describe "validation check" do

		it "is valid with name, email, and password" do
			user = User.new(
				name: "John",
				email: "test@example.com",
				password: "testtest"
			)
			expect(user).to be_valid
		end

		it "is invalid without name" do
			user = User.new(name: nil)
			user.valid?
			expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
			                            # 言語設定が変わっても壊れないバリデーションテスト
		end

		it "is invalid without email" do
			user = User.new(email: nil)
			user.valid?
			expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
		end

		it "is invalid with duplicate email address" do
			user = User.create(
				name: "John",
				email: "test@example.com",
				password: "testtest"
			)

			user = User.new(
				name: "Peter",
				email: "test@example.com",
				password: "testtest"
			)
			expect(user.valid?).to eq(false)
		end

		it "is invalid with a short password" do
			user = User.new(password: 'a' * 5)
			user.valid?
			expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 6))
		end
	end

end