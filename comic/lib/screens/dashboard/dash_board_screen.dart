import 'package:comic/screens/comic_details/comic_details_screen.dart';
import 'package:comic/utils/response_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:intl/intl.dart' as intl;

import 'dash_board_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<DashBoardContestProvider>().getAllComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: contestListView());
  }

  Widget contestListView() => appBehaviourUI(
      context: context,
      response: (context) => context.watch<DashBoardContestProvider>().getComicResponse,
      successBuilder: (context) => (context.watch<DashBoardContestProvider>().getComics.isNotEmpty)
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ComicDetailsScreen(index: i)),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          context.watch<DashBoardContestProvider>().getComics[i].img,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        subtitle: Text(getDateTime(
                          year:context.watch<DashBoardContestProvider>().getComics[i].year,
                          month:context.watch<DashBoardContestProvider>().getComics[i].month,
                          day:context.watch<DashBoardContestProvider>().getComics[i].day
                        ),),
                        title: Text(context.watch<DashBoardContestProvider>().getComics[i].title),
                      ),
                    ),
                  ),
              itemCount: context.watch<DashBoardContestProvider>().getComics.length)
          : const SizedBox());

  String getDateTime({required String year,required String month,required String day}){

    int integerYear=int.parse(year);
    int integerMonth=int.parse(month);
    int integerDay=int.parse(day);

    return intl.DateFormat('dd-MMM-yyyy').format(DateTime(integerYear,integerMonth,integerDay));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
