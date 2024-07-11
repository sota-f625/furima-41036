const price = () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;

      const addTaxDom = Math.floor(inputValue * 0.1);
      const addTaxDomElement = document.getElementById("add-tax-price");
      addTaxDomElement.textContent = addTaxDom;

      const salesProfit = inputValue - addTaxDom;
      const salesProfitElement = document.getElementById("profit");
      salesProfitElement.textContent = salesProfit;
    });
  } else {
  }
};

document.addEventListener("DOMContentLoaded", price);
document.addEventListener("turbo:load", price);
document.addEventListener("turbo:render", price);
