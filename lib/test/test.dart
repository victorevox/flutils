export 'store.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

expectDispatched<State, Action>(
  Store<State> store, {
  Function(Action)? verifier,
}) {
  final Function cb = expectAsync2((dynamic state, dynamic action) {
    if (verifier != null) {
      verifier(action);
    }
  });
  final prevReducer = store.reducer;
  store.reducer = (State state, dynamic action) {
    if (action is Action) {
      cb(state, action);
    }
    if (prevReducer != null) {
      prevReducer(state, action);
    }
    return state;
  };
}

expectDispatchedSync<State, Action>(
  DevToolsStore<State> store, {
  Function(Action)? verifier,
  int? count,
}) {
  final actionStack = store.devToolsState.stagedActions.whereType<Action>();
  expect(actionStack.isNotEmpty, true, reason: "Expected action dispatched");
  if (verifier != null && actionStack.isNotEmpty) {
    verifier(actionStack.first);
  }
  if (count != null) {
    expect(
      actionStack.length,
      count,
      reason: "Expect ${Action} to be called ${count} times",
    );
  }
}

expectNoDispatchedSync<State, Action>(
  DevToolsStore<State> store,
) {
  final action = store.devToolsState.stagedActions.whereType<Action>();
  expect(action.isEmpty, true, reason: "Expected action to not be dispatched");
}

expectDispatchedDelayed<State, Action>(
  DevToolsStore<State> store, {
  Duration duration = const Duration(milliseconds: 400),
  Function(Action)? verifier,
  int? count,
}) async {
  final cb = expectAsync0(() {
    final actionStack = store.devToolsState.stagedActions.whereType<Action>();
    expect(actionStack.isNotEmpty, true, reason: "Expected $Action dispatched");
    if (verifier != null && actionStack.isNotEmpty) {
      verifier(actionStack.first);
    }
    if (count != null) {
      expect(
        actionStack.length,
        count,
        reason: "Expect ${Action} to be called ${count} times",
      );
    }
  });
  await Future.delayed(duration);
  cb();
}

delayed(Function fn,
    {Duration duration = const Duration(milliseconds: 100)}) async {
  final cb = expectAsync0(() {
    fn();
  });
  await Future.delayed(duration);
  cb();
}
