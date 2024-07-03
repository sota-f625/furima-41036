require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let(:user) { create(:user) }
  let!(:item1) { create(:item, user: user, created_at: 1.day.ago) }
  let!(:item2) { create(:item, user: user, created_at: 2.days.ago) }
  let!(:item3) { create(:item, user: user, created_at: 3.days.ago) }
  let!(:sold_out_item) { create(:item, user: user) }
  let!(:purchase) { create(:purchase, item: sold_out_item, user: user) }

  context '商品一覧表示機能' do
    it 'ログイン状況に関係なく、誰でも見ることができる' do
      visit root_path
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item3.name)
    end

    it '出品されている商品が一覧で表示される' do
      visit root_path
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item3.name)
    end

    it '画像が表示されており、画像がリンク切れなどにならない' do
      visit root_path
      expect(page).to have_selector("img[src$='test_image.jpg']")
    end

    it '商品が出品されていない状態では、ダミーの商品情報が表示される' do
      Item.delete_all
      visit root_path
      expect(page).to have_content('商品を出品してね！')
    end

    it '左上から、出品された日時が新しい順に表示される' do
      visit root_path
      items = all('.item-name')
      expect(items[0]).to have_content(item1.name)
      expect(items[1]).to have_content(item2.name)
      expect(items[2]).to have_content(item3.name)
    end

    it '商品出品時に登録した情報のうち、「画像・商品名・価格・配送料の負担」の4つの情報が、見本アプリと同様の形で表示される' do
      visit root_path
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.price)
      expect(page).to have_content(item1.shipping_fee.name)
    end

    it '売却済みの商品は、画像上に「sold out」の文字が表示される' do
      visit root_path
      expect(page).to have_selector('.sold-out', text: 'Sold Out!!')
    end
  end

  context 'Purchaseモデルのバリデーション' do
    it 'ユーザーとアイテムが関連付けられている場合、購入を保存できる' do
      purchase = Purchase.new(user: user, item: item1)
      expect(purchase).to be_valid
    end

    it 'ユーザーが関連付けられていない場合、購入を保存できない' do
      purchase = Purchase.new(item: item1)
      purchase.valid?
      expect(purchase.errors.full_messages).to include('User must exist')
    end

    it 'アイテムが関連付けられていない場合、購入を保存できない' do
      purchase = Purchase.new(user: user)
      purchase.valid?
      expect(purchase.errors.full_messages).to include('Item must exist')
    end
  end
end