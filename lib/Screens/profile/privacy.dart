import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Effective date: April 1, 2024',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Thank you for choosing CookIt, our Recipes Application developed with Flutter. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Information We Collect',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We do not collect any personal information from users of the CookIt application. CookIt does not require you to create an account or provide any personal details such as your name, email address, or phone number.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Automatic Data Collection',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Our application may collect certain information automatically for analytical purposes, including:',
            ),
            Text(
                '- Usage Information: We may collect information about your use of the CookIt application, such as the recipes you view or interact with.'),
            Text(
                '- Device Information: We may collect information about the device you use to access the CookIt application, including the device model, operating system version, unique device identifiers, and mobile network information.'),
            SizedBox(height: 20.0),
            Text(
              'Cookies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'CookIt does not use cookies or similar technologies.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Third-Party Access',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We do not allow any third-party access to the information collected by the CookIt application.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Data Security',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We take the security of your information seriously. We use industry-standard security measures to protect your information from unauthorized access or disclosure.',
            ),
            SizedBox(height: 20.0),
            Text(
              "Children's Privacy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'The CookIt application is not intended for individuals under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us so that we can take appropriate action.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We reserve the right to update or change our Privacy Policy at any time. Any updates or changes will be posted on this page. Your continued use of the CookIt application after we post any modifications to the Privacy Policy will constitute your acknowledgment of the modifications and your consent to abide and be bound by the modified Privacy Policy.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Contact Us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you have any questions or concerns about our Privacy Policy or the CookIt application, please contact us at [Your Contact Email Address].',
            ),
            SizedBox(height: 20.0),
            Text(
              'By using the CookIt application, you agree to the terms and conditions of this Privacy Policy. If you do not agree with the terms of this Privacy Policy, please do not use the CookIt application.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
