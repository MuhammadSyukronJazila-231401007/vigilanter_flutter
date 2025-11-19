import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String name = "Jonto Amgis";
  String email = "jontoAmgis@gmail.com";
  String phone = "08236230****";

  void editField(String field) async {
    String? newValue = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController controller;
        if (field == 'Name') {
          controller = TextEditingController(text: name);
        } else if (field == 'Email') {
          controller = TextEditingController(text: email);
        } else {
          controller = TextEditingController(text: phone);
        }

        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(hintText: 'Masukkan $field'),
            keyboardType:
            field == 'Email' ? TextInputType.emailAddress : TextInputType.text,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                child: Text('Simpan')),
          ],
        );
      },
    );

    if (newValue != null && newValue.trim().isNotEmpty) {
      setState(() {
        if (field == 'Name') {
          name = newValue.trim();
        } else if (field == 'Email') {
          email = newValue.trim();
        } else if (field == 'No. Handphone') {
          phone = newValue.trim();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final iconSize = width * 0.1;

    return Scaffold(
      backgroundColor: AppColors.biruVigilanter,
      appBar: AppBar(
        backgroundColor: Color(0xFF000229),
        elevation: 0,
        leading:
        IconButton(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05
          ),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: width * 0.1,),
          onPressed: () {
            //TODO: navigation
          },
        ),
        title: Text(
          'Account',
          style: TextStyle(
              color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.075
          ) ,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            Stack(
              children: [
                CircleAvatar(
                  radius: iconSize + 8,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: iconSize * 2,
                    color: Color(0xFF000229),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: iconSize * 0.4,
                    backgroundColor: Color(0xFF0F194F),
                    child: Icon(//TODO: edit photo profile
                      Icons.camera_alt_outlined,
                      size: iconSize * 0.5,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: height * 0.05),

            _buildInfoRow(
                context, Icons.person_outline, 'Nama', name, () => editField('Name')),
            SizedBox(height: height * 0.04),
            _buildInfoRow(context, Icons.email_outlined, 'Email', email,
                    () => editField('Email')),
            SizedBox(height: height * 0.04),
            _buildInfoRow(
                context, Icons.phone_outlined, 'No. Handphone', phone, () => editField('No. Handphone')),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label,
      String value, VoidCallback onEditTap) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: width * 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: width * 0.07,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    label,
                    style: TextStyle(
                        color: Colors.white, fontSize: width * 0.045, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.045),
              ),
            ],
          ),
        ),
        GestureDetector( //TODO: edit in database & improve UI
          onTap: onEditTap,
          child: Icon(
            Icons.edit_outlined,
            color: Colors.white,
            size: width * 0.06,
          ),
        )
      ],
    );
  }
}