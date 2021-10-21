import 'package:comic/api/api_manager.dart';
import 'package:comic/screens/dashboard/dash_board_data_classes.dart';

import 'dashboard_repo.dart';

class DashboardRepoImp implements DashboardRepo{
  List<Comic> comicList=[];

  @override
  Future<List<Comic>> getComicList({required int pageNumber}) async {
     await APIManager().getComic(pageNumber: pageNumber).then((value) {
       if(value!=null){
         comicList.add(value);
       }
     });

     return comicList;
  }

}