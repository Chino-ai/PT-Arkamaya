import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about_page';
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Tentang"),),
      body: Container(
        width: 220,
        height: 200,
        margin: EdgeInsets.only(left: 100,top: 30),
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            )
          ],
          border: Border.all(
           width: 2.0,
           style: BorderStyle.solid), //Border.all
           borderRadius: BorderRadius.all(
           Radius.circular(10),
           )

        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Image.asset('assets/ilham.png',width: 100,height: 100,),
              const SizedBox(height: 10,),
              const Text("Ilham Maulana",style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Text("maulanailham510@gmail.com",),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      )
    );
  }
}
