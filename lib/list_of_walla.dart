import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/wals_items.dart';

class ListWalls extends StatefulWidget {
  const ListWalls({super.key});

  @override
  State<ListWalls> createState() => _ListWallsState();
}

class _ListWallsState extends State<ListWalls> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox (height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 220,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                  itemBuilder: (context, index) => const WallsItems(),
                ),
              ),
            ],
          ),
      );
  }
}
