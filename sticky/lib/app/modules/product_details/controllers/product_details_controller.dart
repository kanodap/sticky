import 'package:get/get.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {

  // get product details from arguments
  ProductModel product = Get.arguments;

  // for the product size
  var selectedOption = '1';

  /// when the user press on the favorite button
  onFavoriteButtonPressed() {
    Get.find<BaseController>().onFavoriteButtonPressed(productId: product.id!);
    update(['FavoriteButton']);
  }

  /// when the user press on add to cart button
  onAddToCartPressed() {
    var mProduct = DummyHelper.products.firstWhere((p) => p.id == product.id);
    mProduct.quantity = mProduct.quantity! + 1;
    mProduct.option = selectedOption;
    Get.find<CartController>().getCartProducts();
    Get.back();
  }

  /// change the selected size
  changeSelectedOption(String option) {
    if (option == selectedOption) return;
    selectedOption = option;
    update(['Option']);
  }

}
