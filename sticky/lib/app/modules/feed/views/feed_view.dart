import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../../posting/views/widgets/post_card.dart';
import '../controllers/feed_controller.dart';
import '../../../components/screen_title.dart';
import '../../../components/product_item.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: width > 600 ? Colors.grey[200] : Colors.white,
      appBar: width > 600
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routes.BOOKMARK),
            icon: SvgPicture.asset(
              Constants.bookmarkIcon,
              color: Get.theme.iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routes.FAVORITES),
            icon: SvgPicture.asset(
              Constants.favoritesIcon,
              color: Get.theme.iconTheme.color,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > 600 ? width * 0.3 : 0,
                vertical: width > 600 ? 15 : 0,
              ),
              child: PostCard(
                post: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}






