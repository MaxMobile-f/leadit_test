import 'package:flutter/material.dart';
import 'package:leadit_test/config/text_style.dart';

class PostCard extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final String body;

  const PostCard(
      {Key key,
      @required this.id,
      @required this.name,
      @required this.email,
      @required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: ExpansionTile(
            trailing: Text(
              'post\n№ $id',
              style: T.trailingText,
            ),
            subtitle: Text('author: $email', style: T.subtitleText),
            title: Text(name, style: T.titleText),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 5.0, 10.0, 14.0),
                child: Text(body.toString().replaceAll("\n", " ")),
              ),
            ]),
      );
}
