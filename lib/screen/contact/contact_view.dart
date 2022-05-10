import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/screen/contact/components/contact_bottom_sheet.dart';

class ContactView extends StatefulWidget {
  const ContactView({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  final TextEditingController _searchController = TextEditingController();
  bool _searching = false;
  @override
  void initState() {
    super.initState();
    getContacts();
  }

  void getContacts() async {
    setState(() {
      contacts.add(
        Contact(
          displayName: 'Title',
          givenName: 'Luis Daniel',
          jobTitle: 'My JobTitle',
          company: 'My Company',
        ),
      );
      contacts.add(
        Contact(
          displayName: 'daniel',
        ),
      );
    });
  }

  void searchContacts() {
    final List<Contact> _list = List.from(contacts);
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _searching = true;
      });
      if (_list.isNotEmpty) {
        _list.retainWhere((element) {
          final String searchItem = _searchController.text.toLowerCase();
          return element.displayName!.toLowerCase().contains(searchItem);
        });
        setState(() {
          filteredContacts = _list;
        });
      }
    } else {
      setState(() {
        _searching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        backgroundColor: kHomeBgColor,
      ),
      body: Scaffold(
        backgroundColor: kHomeBgColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (_) => searchContacts(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.only(bottom: 15),
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Search',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      _searching ? filteredContacts.length : contacts.length,
                  itemBuilder: ((context, index) {
                    final Contact contact =
                        _searching ? filteredContacts[index] : contacts[index];
                    return ListTile(
                      leading: getAvatar(contact),
                      title: getTitle(contact),
                      subtitle: getSubtitle(contact),
                      trailing: FittedBox(
                        child: Column(
                          children: [
                            const Text('May 7, 2022, 9 AM'),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ContactBottomSheet();
                                  },
                                );
                              },
                              icon: const Icon(Icons.more_vert),
                              splashRadius: kSplashRadius,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAvatar(Contact contact) {
    if (contact.avatar != null && contact.avatar!.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: MemoryImage(contact.avatar!),
      );
    } else {
      return CircleAvatar(child: Text(contact.initials()));
    }
  }

  Widget getTitle(Contact contact) {
    return Text(
      contact.displayName!,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget getSubtitle(Contact contact) {
    final List<String> buffer = [];
    int i = 0;
    if (contact.jobTitle != null) {
      buffer.insert(i, contact.jobTitle!);
      i++;
    }
    if (contact.company != null) {
      buffer.insert(i, contact.company!);
    }
    return Text(buffer.join(', '));
  }
}
