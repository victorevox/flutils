
import 'package:flutter/widgets.dart';

abstract class ContextProviderService {
  get context;
  setContext(BuildContext context);
}

class ContextProviderServiceImpl implements ContextProviderService {
  ContextProviderServiceImpl();

  BuildContext? _context;

  @override
  get context => _context;

  @override
  setContext(BuildContext context) {
    _context = context;
  }
}