import 'package:comic/screens/dashboard/dash_board_data_classes.dart';

abstract class DashboardRepo{
  Future<List<Comic>> getComicList({required int pageNumber});
}