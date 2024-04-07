import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();

  String selectedEmoji = ''; // Variable to hold the selected emoji

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😡';
                        print('Selected Emoji 1:');
                      });
                    },
                    icon: const Text(
                      '😡',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😕';
                      });
                    },
                    icon: const Text(
                      '😕',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '🙂';
                      });
                    },
                    icon: const Text(
                      '🙂',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😊';
                      });
                    },
                    icon: const Text(
                      '😊',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedEmoji = '😄';
                        print('Selected Emoji 5:');
                      });
                    },
                    icon: const Text(
                      '😄',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: 'Enter your feedback',
                labelStyle: TextStyle(
                  color: Colors.green, 
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey, 
                  ),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF86BF3E),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
