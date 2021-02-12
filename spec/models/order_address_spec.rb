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
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空では購入できない' do
        @order_address.prefecture_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県の情報が--では購入できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市町村が空では購入できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank", "City is invalid. Input full-width characters.")
      end
      it '市町村が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @order_address.city = "hoge1111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City is invalid. Input full-width characters.")
      end
      it '番地が空では購入できない' do
        @order_address.house_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空では購入できない' do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid.")
      end
      it '郵便番号にはハイフンがないと購入できない' do
        @order_address.postal_code = "5100011"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '電話番号にはハイフンがあると購入できない' do
        @order_address.phone_number = "111-1111-1111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid.")
      end
      it '電話番号は11桁以内でないと購入できない' do
        @order_address.phone_number = "111111111111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid.")
      end
      it '電話番号が英数字混合だと登録できない' do
        @order_address.phone_number = "hoge1234"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid.")
      end
      it 'user_idが空だと登録できない' do
        @order_address.user_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと登録できない' do
        @order_address.item_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end