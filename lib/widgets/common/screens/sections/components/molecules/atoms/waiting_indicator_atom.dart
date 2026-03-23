import 'package:flutter/material.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class WaitingIndicator extends StatelessWidget {
  const WaitingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
