import 'package:comic/screens/dashboard/dash_board_provider.dart';
import 'package:comic/widgets/custom_expansion_tile.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ComicDetailsScreen extends StatefulWidget {
  const ComicDetailsScreen({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _ComicDetailsScreenState createState() => _ComicDetailsScreenState();
}

class _ComicDetailsScreenState extends State<ComicDetailsScreen> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
            child: const Icon(Icons.navigate_before),
          ),
          FloatingActionButton(
            onPressed: () {
              controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
            child: const Icon(Icons.navigate_next),
          )
        ],
      ),
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: context
              .watch<DashBoardContestProvider>()
              .getComics
              .map((item) {
                return CustomExpansionTile(
                  top: Image.network(
                    item.img,
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ),
                  title:Text(item.title),
                  trailing: null,
                  children: [Text(item.transcript)],
                );
              })
              .toList()
              .cast<Widget>(),
        ),
      ),
    );
  }
}
