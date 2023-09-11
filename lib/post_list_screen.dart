import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/post_controller.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final scrollController = ScrollController();
    final postController = Get.put(PostController());

    // Attach a scroll listener to the list view
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     // User has reached the end of the list, fetch the next 15 items
    //     // postController.fetchPosts();
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paginated Posts'),
      ),
      body: Obx(
        () => Stack(
          children: [
            ListView.builder(
              //controller: scrollController,
              itemCount: postController.posts.length + 1,
              itemBuilder: (context, index) {
                if (index == postController.posts.length) {
                  // Display loading indicator at the end
                  print(
                      "Index: $index == ${postController.posts.length} postController.post.length ");
                  print("Loading.... for Page = ${postController.page}");
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        postController.loadMorePosts();
                      },
                      child: postController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : const Text("Load More"),
                    ),
                  );
                }
                final post = postController.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.id.toString()),
                );
              },
            ),
            // Display loading Linear or Horizontal progress indicator at the bottom while loading
            if (postController.isLoading.value &&
                postController.posts.isNotEmpty)
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
