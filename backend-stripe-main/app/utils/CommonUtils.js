"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPrice = exports.getCombinedArray = void 0;
function getCombinedArray(cart, productArray) {
    let CombinedArray = [];
    for (let i = 0; i < cart.length; i++) {
        CombinedArray.push({
            ...cart[i],
            ...productArray.find((itemInner) => itemInner.id === cart[i].id),
        });
        cart;
    }
    return CombinedArray;
}
exports.getCombinedArray = getCombinedArray;
function getPrice(cart) {
    let amount = 0;
    cart.forEach((item) => {
        amount += item.price * item.count;
    });
    return amount * 100;
}
exports.getPrice = getPrice;
//# sourceMappingURL=CommonUtils.js.map