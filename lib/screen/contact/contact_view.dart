import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/screen/contact/components/contact_bottom_sheet.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactView extends StatefulWidget {
  const ContactView({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List<Contact> contacts = [];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: ((context, index) {
          final Contact contact = contacts[index];
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
