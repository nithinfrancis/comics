import 'package:comic/repository/dashboard_repo/dashboard_repo_imp.dart';
import 'package:comic/utils/app_response.dart';
import 'package:flutter/cupertino.dart';
import 'dash_board_data_classes.dart';

class DashBoardContestProvider extends ChangeNotifier {

  DashboardRepoImp _dashboardRepoImp = DashboardRepoImp();

  Response<List<Comic>?> _comicListResponse = Response.loading("loading");

  ///Function for get contests
  Future<void> getComicListFromServer({required int pageNumber}) async {
    await  _dashboardRepoImp.getComicList(pageNumber: pageNumber).then((value) {
      _comicListResponse = Response.completed(value);
    }).catchError((e) {
      _comicListResponse = Response.error(e.toString());
    });
    notifyListeners();
  }

  Future<void> getAllComics() async {
    for(int i=1;i<=20;i++){
     await getComicListFromServer(pageNumber: i);
    }
  }

  Response<List<Comic>?> get getComicResponse => _comicListResponse;

  List<Comic> get getComics => _comicListResponse.data ?? [];
}
