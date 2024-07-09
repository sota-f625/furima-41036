require 'rails_helper'

RSpec.describe "PurchaseAddresses", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address_params = {
      post_code: '123-4567',
      prefecture_id: 2,
      city: '東京都',
      address: '青山1-1-1',
      building_name: '柳ビル103',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000' # ダミートークン
    }
  end

  describe "商品購入ページのアクセス制限" do
    context "ログイン状態" do
      it "自身が出品していない販売中商品の商品購入ページに遷移できること" do
        sign_in @user
        get item_purchases_path(@item)
        expect(response).to have_http_status(:success)
      end

      it "自身が出品していない売却済み商品の商品購入ページへ遷移しようとするとトップページに遷移すること" do
        sign_in @user
        FactoryBot.create(:purchase, item: @item, user: FactoryBot.create(:user))
        get item_purchases_path(@item)
        expect(response).to redirect_to(root_path)
      end

      it "自身が出品した商品の商品購入ページに遷移しようとするとトップページに遷移すること" do
        @item.update(user_id: @user.id)
        sign_in @user
        get item_purchases_path(@item)
        expect(response).to redirect_to(root_path)
      end
    end

    context "ログアウト状態" do
      it "商品購入ページに遷移しようとするとログインページに遷移すること" do
        get item_purchases_path(@item)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

    describe "購入処理" do
      context "正常な購入" do
        it "必要な情報を適切に入力して「購入」ボタンを押すと、商品の購入ができること" do
          sign_in @user
          expect {
            post item_purchases_path(@item), params: { purchase_address: @purchase_address_params.merge(user_id: @user.id, item_id: @item.id) }
          }.to change { Purchase.count }.by(1)
        end

        it "購入が完了したらトップページに遷移すること" do
          sign_in @user
          post item_purchases_path(@item), params: { purchase_address: @purchase_address_params.merge(user_id: @user.id, item_id: @item.id) }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "異常な購入" do
      it "入力に問題がある状態で「購入」ボタンが押された場合、情報は受け入れられず、購入ページでエラーメッセージが表示されること" do
        sign_in @user
        @purchase_address_params[:post_code] = ""
        post item_purchases_path(@item), params: { purchase_address: @purchase_address_params.merge(user_id: @user.id, item_id: @item.id) }
        expect(response.body).to include("Post code can't be blank")
      end

      it "エラーハンドリングの際、重複したエラーメッセージが表示されないこと" do
        sign_in @user
        @purchase_address_params[:post_code] = ""
        post item_purchases_path(@item), params: { purchase_address: @purchase_address_params.merge(user_id: @user.id, item_id: @item.id) }
        expect(response.body.scan("can't be blank").count).to eq(1)
      end
    end
  end
end