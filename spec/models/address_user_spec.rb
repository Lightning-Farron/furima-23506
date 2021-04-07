require 'rails_helper'

RSpec.describe AddressUser, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @address =FactoryBot.build(:address_user, user_id: @user.id) 
    sleep(1)
  end

  describe "住所登録" do
    context '住所登録できるとき' do
      it "郵便番号、都道府県、市町村、番地、電話番号の情報があれば、住所登録ができる" do
        expect(@address).to be_valid
      end
      it "建物名が空でも登録できる" do
        @address.building_name =""
        expect(@address).to be_valid
      end
    end
    context '住所登録できないとき' do
      it '郵便番号が空では登録できない' do
        @address.postal_code = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end
      it '都道府県が空では登録できない' do
        @address.prefecture_id = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("都道府県を入力してください")
      end
      it '都道府県の情報が--では登録できない' do
        @address.prefecture_id = 0
        @address.valid?
        expect(@address.errors.full_messages).to include("都道府県は0以外の値にしてください")
      end
      it '市町村が空では登録できない' do
        @address.city = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("市区町村を入力してください", "市区町村は不正な値です")
      end
      it '市町村が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @address.city = "hoge1111"
        @address.valid?
        expect(@address.errors.full_messages).to include("市区町村は不正な値です")
      end
      it '番地が空では登録できない' do
        @address.house_number = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では登録できない' do
        @address.phone_number = ""
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end
      it '郵便番号にはハイフンがないと登録できない' do
        @address.postal_code = "5100011"
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '電話番号にはハイフンがあると登録できない' do
        @address.phone_number = "111-1111-1111"
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号は11桁以内でないと登録できない' do
        @address.phone_number = "111111111111"
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が英数字混合だと登録できない' do
        @address.phone_number = "hoge1234"
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号は不正な値です")
      end
    end
  end
end
