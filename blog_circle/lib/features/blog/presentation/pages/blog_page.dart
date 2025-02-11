import 'package:blog_circle/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                AddNewBlogPage.route(),
              );
            },
            icon: Icon(
              CupertinoIcons.add_circled,
            ),
          )
        ],
      ),
    );
  }
}
