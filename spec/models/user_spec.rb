require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録できるとき' do
      it "nickname、email、パスワード、パスワード確認、名字、名前、名字のフリカナ、名前のフリカナ、生年月日があれば登録できる" do
        expect(@user).to be_valid
      end
      it "パスワードが6文字以上であれば登録できる" do
        @user.password = "fuga1212"
        @user.password_confirmation = "fuga1212"
        expect(@user).to be_valid
      end
      it "パスワードは、半角英数字混合での入力で登録できる" do
        @user.password = "fuga1212"
        @user.password_confirmation = "fuga1212"
        expect(@user).to be_valid
      end
      it "名字が全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.last_name = "ヤま田"
        expect(@user).to be_valid
      end
      it "名前が全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.first_name = "太ろウ"
        expect(@user).to be_valid
      end
      it "名字のフリカナが全角（カタカナ）であれば登録できる" do
        expect(@user).to be_valid
      end
      it "名前のフリカナが全角（カタカナ）であれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "メールアドレスが一意性であること" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "メールアドレスは、@を含む必要があること" do
        @user.email = "fugaprog-8.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it "パスワードが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "パスワードは、6文字以上での入力が必須であること" do
        @user.password = "fuga1"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください", "パスワードは不正な値です")
      end
      it "パスワードは、半角英数字混合での入力が必須であること" do
        @user.password = "fugafuga"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end
      it "パスワードは、数字のみでは登録できない" do
        @user.password = "12121212"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end
      it "パスワードは、全角では登録できない" do
        @user.password = "ｆｕｇａｆｕｇａ"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end
      it "パスワードは、確認用を含めて2回入力すること" do
        @user.password = "fuga1111"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "パスワードとパスワード（確認用）、値の一致が必須であること" do
        @user.password = "fuga1111"
        @user.password_confirmation = "fuga2222"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "ユーザー本名は、名字が必須であること" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください", "名字は不正な値です")
      end
      it "ユーザー本名は、名前が必須であること" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は不正な値です")
      end
      it "ユーザー本名の、名字は全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
        @user.last_name = "fuga12"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は不正な値です")
      end
      it "ユーザー本名の、名前は全角（漢字・ひらがな・カタカナ）での入力が必須であること" do
        @user.first_name = "fuga12"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it "ユーザー本名のフリガナの、名字が必須であること" do
        @user.last_name_reading = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名字のフリガナを入力してください", "名字のフリガナは不正な値です")
      end
      it "ユーザー本名のフリガナの、名前が必須であること" do
        @user.first_name_reading = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のフリガナを入力してください", "名前のフリガナは不正な値です")
      end
      it "ユーザー本名の名字のフリガナは、全角（カタカナ）での入力が必須であること" do
        @user.last_name_reading = "fugafuga"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字のフリガナは不正な値です")
      end
      it "ユーザー本名の名前のフリガナは、全角（カタカナ）での入力が必須であること" do
        @user.first_name_reading = "fugafuga"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のフリガナは不正な値です")
      end
      it "生年月日が必須であること" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end