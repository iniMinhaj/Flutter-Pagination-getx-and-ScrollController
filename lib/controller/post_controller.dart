import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/post_model.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var page = 1;
  final itemsPerPage = 15;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/posts?_start=${(page - 1) * itemsPerPage}&_limit=$itemsPerPage'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final newPosts = data.map((json) => Post.fromJson(json)).toList();
        posts.addAll(newPosts);
        page++;
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
