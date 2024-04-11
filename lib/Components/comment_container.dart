import 'package:flutter/material.dart';

class CommentContainer extends StatelessWidget {
  const CommentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: FadeInImage(
              placeholder: const AssetImage('assets/avatar.png'),
              image: const AssetImage('assets/avatar.png'),
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60.0,
                  height: 60.0,
                  color: Colors.grey,
                  child: const Center(child: Icon(Icons.error)),
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text('comment',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}