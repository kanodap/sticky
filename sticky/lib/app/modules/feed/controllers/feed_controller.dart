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

  void getPostings() {
    postings = DummyHelper.products;
    update();
  }

  /// 특정 제품의 북마크 상태를 토글하는 함수
  void toggleBookmark(int postId) {
    int index = postings.indexWhere((post) => post.id == postId);
    if (index != -1) {
      postings[index].isBookmarked = !(postings[index].isBookmarked ?? false);
      update();
    }
  }
}

