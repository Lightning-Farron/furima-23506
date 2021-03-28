require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe "タグ登録" do
    context 'タグ登録できないとき' do
      it "タグの情報が重複では登録出来ない" do
        @tag.save
        another_tag = FactoryBot.build(:tag)
        another_tag.tag_name = @tag.tag_name
        another_tag.valid?
        expect(another_tag.errors.full_messages).to include("タグはすでに存在します")
      end
    end
  end
end


