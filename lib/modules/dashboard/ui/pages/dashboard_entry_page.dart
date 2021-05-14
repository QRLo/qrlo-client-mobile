import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/dashboard/states/bottom_navigation_state.dart';
import 'package:qrlo_mobile/modules/data_store/ui/data_store_view.dart';
import 'package:qrlo_mobile/modules/profile/ui/bottomsheets/business_card_creation_view.dart';
import 'package:qrlo_mobile/modules/profile/ui/profile_view.dart';
import 'package:qrlo_mobile/modules/qrcode/ui/qrcode_scan_view.dart';
import 'package:qrlo_mobile/modules/settings/ui/settings_view.dart';

class DashboardEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavigationState(),
      child: Consumer<BottomNavigationState>(
        builder: (context, provider, _) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  provider.currTab.title,
                  textAlign: TextAlign.center,
                ),
              ),
              body: Builder(
                builder: (context) {
                  switch (provider.currTab) {
                    case NavigationTab.profile:
                      return ProfileView();
                    case NavigationTab.scan:
                      return QRCodeScanView();
                    case NavigationTab.settings:
                      return SettingsView();
                    case NavigationTab.saved:
                      return DataStoreView();
                    case NavigationTab.contacts:
                      return Container(
                        child: Center(
                          child: Text(provider.currTab.index.toString()),
                        ),
                      );
                    default:
                      throw 'BAAAD';
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: provider.navigateTo,
                currentIndex: provider.currTab.index,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.connect_without_contact),
                    label: "Contact",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera_enhance),
                    label: "Scan",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Saved",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Settings",
                  ),
                ],
              ),
              floatingActionButton: Builder(
                builder: (context) {
                  if (provider.currTab == NavigationTab.profile)
                    return FloatingActionButton(
                      elevation: 0.0,
                      child: Icon(Icons.add),
                      backgroundColor: Color(0xFFE57373),
                      onPressed: () => {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return BusinessCardCreationView(
                                key: Key('business_card_creation_view'));
                          },
                        ),
                      },
                    );
                  return Column();
                },
              ));
        },
      ),
    );
  }
}
