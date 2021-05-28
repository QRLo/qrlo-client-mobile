import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/profile/states/profile_state.dart';
import 'package:qrlo_mobile/modules/profile/ui/cards/business_card_card_view.dart';
import 'package:qrlo_mobile/modules/qrcode/models/user_business_card.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();

  static showCreateProfileDataForm() {}
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileState>().fetchAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();

    final components = _buildProfileComponents(profileState.myBusinessCards);
    return Column(
      children: [
        Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.all(8.0),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "${profileState.basicProfile?.lastName}${profileState.basicProfile?.firstName}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://kansai-resilience-forum.jp/wp-content/uploads/2019/02/IAFOR-Blank-Avatar-Image-1.jpg',
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "${profileState.basicProfile?.email}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          return (components.length == 0)
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "큐알로를 시작해보세요!",
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Flex(
                      direction: Axis.vertical,
                      children: [...components],
                    ),
                  ),
                );
        }),
      ],
    );
  }

  List<Widget> _buildProfileComponents(List<UserBusinessCard> businessCards) {
    return businessCards
        .map((businessCard) => BusinessCardCardView(
            key: Key(businessCard.id!.toString()), businessCard: businessCard))
        .toList();
  }
}
