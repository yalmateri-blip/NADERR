import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAddMenu = false;
  bool isGrid = false;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  double sliderValue = 0.5;

  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();

  Future<void> pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
              ),
            ),
            Expanded(
              child: Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'البحث في Keep',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isGrid = !isGrid;
                        });
                      },
                      child: Icon(
                        isGrid
                            ? Icons.view_agenda
                            : Icons.grid_view,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Google Keep',
                style:
                TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.white),
                  SizedBox(width: 16),
                  Text('ملاحظات',
                      style:
                      TextStyle(color: Colors.white)),
                ],
              ),
            ),
            drawerItem(Icons.notifications, 'رسائل التذكير'),
            drawerItem(Icons.add, 'إنشاء تصنيف جديد'),
            drawerItem(Icons.archive, 'الأرشيف'),
            drawerItem(Icons.delete, 'المهملات'),
            drawerItem(Icons.settings, 'الإعدادات'),
            drawerItem(Icons.help, 'المساعدة والملاحظات'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lightbulb_outline,
                    size: 100, color: Colors.grey),
                SizedBox(height: 20),
                Text(
                  'تظهر الملاحظات التي تضيفها هنا',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),


          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Slider(
              value: sliderValue,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
          ),

          if (showAddMenu)
            Positioned(
              bottom: 90,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addItem(Icons.mic, 'ملاحظة صوتية'),
                  addItem(Icons.image, 'صورة', onTap: pickImage),
                  addItem(Icons.brush, 'رسم'),
                  addItem(Icons.check_box, 'قائمة'),
                  addItem(Icons.text_fields, 'نص'),
                ],
              ),
            ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[200],
        onPressed: () {
          setState(() {
            showAddMenu = !showAddMenu;
          });
        },
        child: Icon(
          showAddMenu ? Icons.close : Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget addItem(IconData icon, String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding:
        EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(text,
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title:
      Text(text, style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
