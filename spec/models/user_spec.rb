require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    it "nicknameが空では登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "メールアドレスが一意性であること" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "メールアドレスは、@を含む必要があること" do
      @user.email = "fugaprog-8.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "パスワードが空では登録できない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "パスワードは、6文字以上での入力が必須であること" do
      @user.password = "fuga1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it "パスワードは、半角英数字混合での入力が必須であること" do
      @user.password = "fugafuga"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end
    it "パスワードは、確認用を含めて2回入力すること" do
      @user.password = "fuga1111"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "パスワードとパスワード（確認用）、値の一致が必須であること" do
      @user.password = "fuga1111"
      @user.password_confirmation = "fuga2222"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "ユーザー本名は、名字が必須であること" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it "ユーザー本名は、名前が必須であること" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "ユーザー本名の、名字は全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
      @user.last_name = "fuga12"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end
    it "ユーザー本名の、名前は全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
      @user.first_name = "fuga12"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it "ユーザー本名のフリガナの、名字が必須であること" do
      @user.last_name_reading = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading can't be blank")
    end
    it "ユーザー本名のフリガナの、名前が必須であること" do
      @user.first_name_reading = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading can't be blank")
    end
    it "ユーザー本名の名字のフリガナは、全角（カタカナ）での入力が必須であること" do
      @user.last_name_reading = "fugafuga"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading is invalid")
    end
    it "ユーザー本名の名前のフリガナは、全角（カタカナ）での入力が必須であること" do
      @user.first_name_reading = "fugafuga"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading is invalid")
    end
    it "生年月日が必須であること" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end
end
