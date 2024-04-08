import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController _feedbackController = TextEditingController();
  String rating = ''; 

  void addFeedback() async {
    if(_feedbackController.text.isNotEmpty && rating != ''){
      bool isSuccess = await DatabaseService.addFeedback(rating, _feedbackController.text.trim());
      if(isSuccess){
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Thank you! Your feedback has been added.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sorry an error occurred.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }     
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please add your feedback.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Feedback'),
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
                      setState(() => rating = '1');
                    },
                    icon: const Text(
                      '😡',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => rating = '2');
                    },
                    icon: const Text(
                      '😕',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => rating = '3');
                    },
                    icon: const Text(
                      '🙂',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => rating = '4');
                    },
                    icon: const Text(
                      '😊',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => rating = '5');
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
              onPressed: addFeedback,
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
