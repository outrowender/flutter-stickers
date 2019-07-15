import 'package:flutter/cupertino.dart';
import 'package:interoperabilidade/views/apple/search/sticker.row.item.cupertino.dart';

class SearchAppleView extends StatefulWidget {
  @override
  _SearchAppleViewState createState() => _SearchAppleViewState();
}

class _SearchAppleViewState extends State<SearchAppleView> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Flutter stickers'),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < 2) {
                    return StickerRowItem(
                      lastItem: index == 1,
                    );
                  }
                  return null;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
