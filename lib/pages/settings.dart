import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S E T T I N G S'),
      ),
      body: Container(
        decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15)

        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

            CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
            onChanged: (value)=> Provider.of<ThemeProvider>(context, listen: false).toggleTheme())



          ],
        ),
      ),

    );
  }
}