import 'package:flutter/material.dart';

import 'app_response.dart';

Widget appBehaviourUI({
  required BuildContext context,
  required Response Function(BuildContext context) response,
  required Widget Function(BuildContext context) successBuilder,
}) {
  if (response(context).status == Status.LOADING) {
    return Center(child: CircularProgressIndicator(),);
  } else if (response(context).status == Status.ERROR) {
    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${response(context).message}"),
      ],
    ));
  } else if (response(context).status == Status.COMPLETED) {
    return successBuilder(context);
  } else {
    return SizedBox();
  }
}