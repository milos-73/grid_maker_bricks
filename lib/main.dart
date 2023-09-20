import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:provider/provider.dart';

import 'color_list.dart';
import 'grid_items.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<BrickColorNumber>(create: (context) => BrickColorNumber())
      ], child: const MyApp()));
     }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox (height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.builder(
              shrinkWrap: true,
              itemCount: 220,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
              itemBuilder: (context, index) => ItemTile(index),
               ),
            ),
            const SizedBox(height: 10),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox (height: MediaQuery.of(context).size.height * 0.3,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 73,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                    itemBuilder: (context, index) => ColorList(index),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
           Row(
             children: [
             Column(children: [
               SizedBox(width: 100, height: 50,
                 child: ElevatedButton(onPressed: (){
                   Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(0);
                   setState(() {

                 });},style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.green,
             ), child: const Text('Resset'),),
               )],),
             Column(children: [],)
           ],) 
          ],
        ),
      ),
     );
  }
}
