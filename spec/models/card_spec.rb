require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = FactoryBot.build(:card)
  end

  describe "トークン登録" do
    context 'トークン登録できないとき' do
      it "トークンの情報が空では登録出来ない" do
        @card.card_token = ""
        @card.valid?
        expect(@card.errors.full_messages).to include("トークンを入力してください")
      end
    end
  end
  
end
