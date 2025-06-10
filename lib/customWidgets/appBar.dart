import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade400,
      iconTheme: IconThemeData(
        color: Colors.white, // Set the icon color here
      ),
      elevation: 4,
      title: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/school-details');
            },child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Image.asset(
              'assets/school.png',
              width: AppTheme.logoSize,
              height: AppTheme.logoSize,
            ),
          ),
          ),
          SizedBox(width: 20,),
          GestureDetector(
            onTap:(){
              Navigator.pushNamed(context,'/student-dashboard');
            },child: Text(
            'Royal Public School',
            style:  TextStyle(
              fontSize: 22,
              color: AppTheme.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/main-chat');
            },child: Icon(Icons.chat),
          ),
          SizedBox(width: AppTheme.smallSpacing,),
          GestureDetector(
            onTap:(){
              Navigator.pushNamed(context,'/notifications');
            },child: Icon(Icons.notifications),
          ),
        ],
      ),

    );

  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}