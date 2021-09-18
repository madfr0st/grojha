class CartTemp {
  String shopName;
  int cartUniqueProducts;
  int cartTotalProductCost;
  String shopCategory;
  String shopId;
  String shopImage;

  CartTemp(this.shopId,this.shopName,this.shopCategory, this.cartTotalProductCost, this.cartUniqueProducts,
      this.shopImage) {
    if (shopImage == null || shopImage.length == 0) {
      shopImage = "https://firebasestorage.googleapis.com/v0/b/project-red-117.appspot.com/o/defaultImages%2FDefaultShopImage.png?alt=media&token=bb7b949f-fb1b-42a4-ae24-22f3d8bd22fd";
    }
  }
}
