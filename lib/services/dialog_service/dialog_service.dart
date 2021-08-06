import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/widgets.dart';

import '../../flutils.dart';

abstract class DialogService {
  showDialog({
    required String title,
    required String description,
    List<Widget>? contentList,
  });
}

class DialogServiceImpl implements DialogService {
  // final GlobalKey<NavigatorState> navigationKey;
  final ContextProviderService contextProvider;
  late Widget Function(String title) _titleBuilder;
  late Widget Function(String message) _messageBuilder;
  late Widget Function(Widget content) _customWrapper;

  DialogServiceImpl({
    required this.contextProvider,
    Widget Function(String title)? titleBuilder,
    Widget Function(String message)? messageBuilder,
    Widget Function(Widget content)? customWrapper,
  }) {
    _titleBuilder = titleBuilder ??
        (title) => Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
    _messageBuilder = messageBuilder ??
        (message) => Text(
              message,
              style: TextStyle(
                fontSize: 14,
              ),
            );
    _customWrapper = customWrapper ??
        (content) => Container(
              child: SingleChildScrollView(
                child: content,
              ),
              constraints: BoxConstraints(
                maxHeight: 120,
                minHeight: 90,
              ),
            );
  }

  void showDialog(
      {required String title,
      required String description,
      List<Widget>? contentList}) {
    // final context = navigationKey.currentState.context;
    List<Widget> list = [
      _titleBuilder(title),
      SizedBox(
        height: 8,
      ),
      _messageBuilder(description),
    ]..addAll(contentList ?? []);
    // List<Widget>
    EasyDialog(
      titlePadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      // title: AppHeading("$title", headingType: AppHeadingType.h2,),
      // description: Text("This is a basic dialog"),
      contentList: [
        _customWrapper(
          Column(
            children: list,
          ),
        ),
      ],
      height: 150,
    ).show(contextProvider.context);
  }
}
