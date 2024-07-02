document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;

      const tax = Math.floor(inputValue * 0.1);
      const profitValue = inputValue - tax;

      addTaxPrice.innerHTML = tax;
      profit.innerHTML = profitValue;
    });
  }
});