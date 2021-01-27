require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品出品登録" do
    context '商品出品登録できるとき' do
      it "商品画像、商品名、商品の説明、カテゴリーの情報、商品の状態、配送料の負担についての情報、発送元の地域についての情報、発送までの日数についての情報、価格についての情報があれば登録できる" do
        expect(@item).to be_valid
      end
    end
    context '商品出品登録できないとき' do
      it "商品画像が空では登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名が空では登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の説明が空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "カテゴリーの情報が空では登録できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "カテゴリーの情報が--では登録できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it "商品の状態についての情報が空では登録できない" do
        @item.condition_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it "商品の状態が--では登録できない" do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 0")
      end
      it "配送料の負担についての情報が空では登録できない" do
        @item.shipping_charge_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
      end
      it "配送料の負担が--では登録できない" do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge must be other than 0")
      end
      it "発送元の地域についての情報が空では登録できない" do
        @item.prefectures_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefectures can't be blank")
      end
      it "発送元の地域についての情報が--では登録できない" do
        @item.prefectures_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefectures must be other than 0")
      end
      it "発送までの日数についての情報が空では登録できない" do
        @item.pays_to_ship_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Pays to ship can't be blank")
      end
      it "発送までの日数についての情報が--では登録できない" do
        @item.pays_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Pays to ship must be other than 0")
      end
      it "価格についての情報が空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格が¥300以下のとき登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 299")
      end
      it "価格が¥9,999,999以上のとき登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 10000000")
      end
      it "販売価格は半角数字でなければ登録できない" do
        @item.price = "３０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is too short (minimum is 3 characters)", "Price is not a number")
      end
      it "価格が半角英数混合では登録できない" do
        @item.price = "hoge11"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "価格が半角英語では登録できない" do
        @item.price = "hoge"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
