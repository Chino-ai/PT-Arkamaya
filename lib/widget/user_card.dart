import 'package:flutter/material.dart';
import 'package:pt_arkamaya/model/list_user.dart';
import 'package:pt_arkamaya/ui/single_user_page.dart';


class UserCard extends StatelessWidget {
  final Datum datum;

  UserCard(this.datum);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, SingleUserPage.routeName,
                arguments: datum.id.toString());
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.network(
                    datum.avatar.toString(),
                    width: 60,
                    height: 60,
                  ),
                  title: Text("${datum.firstName} ${datum.lastName}"),
                  subtitle: Text(datum.email),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
