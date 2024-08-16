import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

class PostCard extends StatelessWidget {
  final String profilePicUrl;
  final String name;
  final String postedTime;
  final String postImageUrl;
  final String description;
  final int likes;
  final int comments;

  const PostCard({
    required this.profilePicUrl,
    required this.name,
    required this.postedTime,
    required this.postImageUrl,
    required this.description,
    required this.likes,
    required this.comments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final Size screenSize = MediaQuery.of(context).size;
    // Calculate a dynamic height for the post content (e.g., 50% of screen height)
    final double postContentHeight = screenSize.height * 0.26;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Section
        Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(profilePicUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        postedTime,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            // Post Image
                
                 SizedBox(
                  height: postContentHeight,
                   child: Container(
                           margin: const EdgeInsets.only(left: 55),
                           child: ClipRRect(
                             borderRadius: const BorderRadius.only(
                               topLeft: Radius.circular(16),
                               bottomLeft: Radius.circular(16),
                             ),
                             child: Image.network(
                               postImageUrl,
                               fit: BoxFit.cover,
                               width: double.infinity,
                             ),
                           ),
                                   ),
                 ),
                kheight15,
                // Description
                Container(
        margin: const EdgeInsets.only(left: 55, bottom: 16, right: 4),
        child: Text(
          description,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.left, 
          softWrap: true, 
          overflow: TextOverflow.visible,
        ),
                ),
                // Like and Comment Section
                Container(
        margin: const EdgeInsets.only(left: 55),
        child: Row(
          children: [
            const Icon(Icons.favorite_border, size: 20),
            const SizedBox(width: 8),
            Text('$likes'),
            const SizedBox(width: 16),
            const Icon(Icons.comment_outlined, size: 20),
            const SizedBox(width: 8),
            Text('$comments'),
          ],
        ),
                ),
          ],
        ),
        kheight15
      ],
    );
  }
}
