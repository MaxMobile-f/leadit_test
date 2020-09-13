import 'package:flutter/material.dart';

class ViewStateErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewStateErrorWidget({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, size: 100, color: Colors.white24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text('Check internet connection.'),
          ),
          FlatButton(
            child: Text('Retry'),
            color: Colors.white24,
            onPressed: onPressed,
            highlightColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
