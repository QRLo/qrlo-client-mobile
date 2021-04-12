import 'dart:collection';

import 'package:flutter/material.dart';

class BottomNavigationState extends ChangeNotifier {
  ListQueue _tabStack = ListQueue.from([NavigationTab.profile.index]);

  NavigationTab get currTab => NavigationTab.values[_tabStack.last];

  void navigateTo(int tabIndex) {
    _tabStack.addLast(tabIndex);
    notifyListeners();
  }

  void pop() {
    _tabStack.removeLast();
    notifyListeners();
  }
}

enum NavigationTab { profile, contacts, scan, saved, settings }

extension NavigationTabExtension on NavigationTab {
  String get title => describeTitle();

  String describeTitle() {
    switch (this) {
      case NavigationTab.profile:
        return 'Profile';
      case NavigationTab.contacts:
        return 'Contacts';
      case NavigationTab.scan:
        return 'Scan';
      case NavigationTab.saved:
        return 'Saved';
      case NavigationTab.settings:
        return 'Settings';
      default:
        throw 'Unsupported NavigationTab';
    }
  }
}
