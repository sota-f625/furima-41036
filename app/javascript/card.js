const pay = () => {
  const publicKey = gon.public_key; // gonで公開鍵を取得
  const payjp = Payjp(publicKey); // 公開鍵を使用してPayjpオブジェクトを作成
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form'); // カード番号入力フィールドをマウント
  expiryElement.mount('#expiry-form'); // 有効期限入力フィールドをマウント
  cvcElement.mount('#cvc-form');       // セキュリティコード入力フィールドをマウント

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        // エラーメッセージの表示など
      } else {
        const token = response.id;
        console.log(token);

        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);

        // カード情報をクリアする
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay); // turbo:loadイベント時にpay関数を実行