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
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it "商品名が空では登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it "商品の説明が空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it "カテゴリーの情報が空では登録できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください", "カテゴリーは数値で入力してください")
      end
      it "カテゴリーの情報が--では登録できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは0以外の値にしてください")
      end
      it "商品の状態についての情報が空では登録できない" do
        @item.condition_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品状態を入力してください", "商品状態は数値で入力してください")
      end
      it "商品の状態が--では登録できない" do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品状態は0以外の値にしてください")
      end
      it "配送料の負担についての情報が空では登録できない" do
        @item.shipping_charge_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください", "配送料の負担は数値で入力してください")
      end
      it "配送料の負担が--では登録できない" do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は0以外の値にしてください")
      end
      it "発送元の地域についての情報が空では登録できない" do
        @item.prefecture_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください", "発送元の地域は数値で入力してください")
      end
      it "発送元の地域についての情報が--では登録できない" do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は0以外の値にしてください")
      end
      it "発送までの日数についての情報が空では登録できない" do
        @item.pays_to_ship_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください", "発送までの日数は数値で入力してください")
      end
      it "発送までの日数についての情報が--では登録できない" do
        @item.pays_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は0以外の値にしてください")
      end
      it "価格についての情報が空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は不正な値です", "価格は3文字以上で入力してください", "価格は数値で入力してください")
      end
      it "価格が¥300以下のとき登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は299より大きい値にしてください")
      end
      it "価格が¥9,999,999以上のとき登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は10000000より小さい値にしてください")
      end
      it "販売価格は半角数字でなければ登録できない" do
        @item.price = "３０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は3文字以上で入力してください", "価格は数値で入力してください")
      end
      it "価格が半角英数混合では登録できない" do
        @item.price = "hoge11"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は3文字以上で入力してください", "価格は数値で入力してください")
      end
      it "価格が半角英語では登録できない" do
        @item.price = "hoge"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は3文字以上で入力してください", "価格は数値で入力してください")
      end
    end
  end
end
