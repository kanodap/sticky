import 'package:get/get.dart';

import '../controllers/sticker_controller.dart';

class StickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StickerController>(
            () => StickerController()
    );
  }
}
