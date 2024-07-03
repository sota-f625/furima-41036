const price = () => {
  console.log("Event run"); // デバッグ用ログ
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    console.log("Price input found."); // デバッグ用ログ
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      console.log("Input value:", inputValue); // デバッグ用ログ

      const addTaxDom = Math.floor(inputValue * 0.1);
      const addTaxDomElement = document.getElementById("add-tax-price");
      addTaxDomElement.textContent = addTaxDom;

      const salesProfit = Math.floor(inputValue * 0.9);
      const salesProfitElement = document.getElementById("profit");
      salesProfitElement.textContent = salesProfit;
    });
  } else {
    console.log("Price input not found."); // デバッグ用ログ
  }
};

document.addEventListener("DOMContentLoaded", price);
document.addEventListener("turbo:render", price);
console.log("Price activated"); // デバッグ用ログ