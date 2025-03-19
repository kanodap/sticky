import 'package:get/get.dart';

class StickerController extends GetxController {
  var stickerResults = <String>[].obs; // Observable list for sticker results
  var isLoading = false.obs; // Observable boolean for loading state

  /// Method to search for stickers
  void searchStickers(String keyword) async {
    if (keyword.isEmpty) return;

    try {
      isLoading.value = true;
      // Simulating network request delay
      await Future.delayed(Duration(seconds: 2));
      // Replace with actual search logic
      stickerResults.value = ["https://example.com/sticker1.png", "https://example.com/sticker2.png"];
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
