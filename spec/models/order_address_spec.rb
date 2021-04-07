require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep(1)
  end

  describe "商品購入" do
    context '商品購入できるとき' do
      it "郵便番号、都道府県、市町村、番地、電話番号の情報があれば、商品の購入ができる" do
        expect(@order_address).to be_valid
      end
      it "建物名が空でも購入できる" do
        @order_address.building_name =""
        expect(@order_address).to be_valid
      end
    end
    context '商品購入できないとき' do
      it '郵便番号が空では購入できない' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end
      it '都道府県が空では購入できない' do
        @order_address.prefecture_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を入力してください", "都道府県は数値で入力してください")
      end
      it '都道府県の情報が--では購入できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県は0以外の値にしてください")
      end
      it '市町村が空では購入できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください", "市区町村は不正な値です")
      end
      it '市町村が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @order_address.city = "hoge1111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村は不正な値です")
      end
      it '番地が空では購入できない' do
        @order_address.house_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では購入できない' do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end
      it '郵便番号にはハイフンがないと購入できない' do
        @order_address.postal_code = "5100011"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '電話番号にはハイフンがあると購入できない' do
        @order_address.phone_number = "111-1111-1111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号は11桁以内でないと購入できない' do
        @order_address.phone_number = "111111111111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が英数字混合だと登録できない' do
        @order_address.phone_number = "hoge1234"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'user_idが空だと登録できない' do
        @order_address.user_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'item_idが空だと登録できない' do
        @order_address.item_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("商品を入力してください")
      end
      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("トークンを入力してください")
      end
    end
  end
end