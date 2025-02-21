import 'package:get/get.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';

class FeedController extends GetxController {

  List<ProductModel> postings = [];

  @override
  void onInit() {
    getPostings();
    super.onInit();
  }

  getPostings() {
    postings = DummyHelper.products;
  }
}
