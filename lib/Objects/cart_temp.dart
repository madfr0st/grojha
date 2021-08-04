class CartTemp {
  String shopName;
  int cartUniqueProducts;
  int cartTotalCost;
  String shopCategory;
  String shopId;
  String shopImage;

  CartTemp(this.shopId,this.shopName,this.shopCategory, this.cartTotalCost, this.cartUniqueProducts,
      this.shopImage) {
    if (shopImage == null || shopImage.length == 0) {
      shopImage = "https://picsum.photos/250?image=9";
    }
  }
}
