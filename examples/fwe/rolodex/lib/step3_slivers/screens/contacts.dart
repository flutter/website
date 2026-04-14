import 'package:flutter/cupertino.dart';
import '../data/contact.dart';
import '../data/contact_group.dart';
import '../main.dart';

class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListView(listId: listId);
  }
}

class _ContactListView extends StatelessWidget {
  const _ContactListView({
    required this.listId,
    this.automaticallyImplyLeading = true,
  });

  final int listId;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: contactGroupsModel.listsNotifier,
        builder: (context, contactGroups, child) {
          final ContactGroup contactList = contactGroupsModel.findContactList(
            listId,
          );

          final AlphabetizedContactMap contacts =
              contactList.alphabetizedContacts;

          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar.search(
                largeTitle: Text(contactList.title),
                automaticallyImplyLeading: automaticallyImplyLeading,
                searchField: const CupertinoSearchTextField(
                  suffixIcon: Icon(CupertinoIcons.mic_fill),
                  suffixMode: OverlayVisibilityMode.always,
                ),
              ),
              SliverList.list(
                children: [
                  const SizedBox(height: 20),
                  ...contacts.keys.map(
                    (String initial) => ContactListSection(
                      lastInitial: initial,
                      contacts: contacts[initial]!,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// #docregion contact_list_section
class ContactListSection extends StatelessWidget {
  const ContactListSection({
    super.key,
    required this.lastInitial,
    required this.contacts,
  });

  final String lastInitial;
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              lastInitial,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CupertinoListSection(
            backgroundColor: CupertinoColors.systemBackground,
            dividerMargin: 0,
            additionalDividerMargin: 0,
            topMargin: 4,
            children: [
              for (final Contact contact in contacts)
                CupertinoListTile(
                  padding: const EdgeInsets.all(0),
                  title: Text('${contact.firstName} ${contact.lastName}'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
// #enddocregion contact_list_section
