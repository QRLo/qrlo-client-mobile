import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/modules/profile/states/profile_state.dart';
import 'package:qrlo_mobile/modules/profile/ui/cards/business_card_card_view.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({required Key key}) : super(key: key);

  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileState>().fetchAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: context
            .read<ProfileState>()
            .contacts
            .map((businessCard) => BusinessCardCardView(
                key: Key(businessCard.id!.toString()),
                businessCard: businessCard))
            .toList(),
      ),
    );
  }
}
