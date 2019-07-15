import 'package:flutter/cupertino.dart';
import 'package:interoperabilidade/styles.apple.dart';
import 'package:interoperabilidade/views/apple/pack/pack.apple.view.dart';

class StickerRowItem extends StatelessWidget {
  const StickerRowItem({this.lastItem});

  final bool lastItem;

  final String url =
      'https://firebasestorage.googleapis.com/v0/b/flutter-stickers.appspot.com/o/source%2F1wbd8uVnXEhqzPUBBZFF%2Ftray_Cuppy.png?alt=media&token=8d1c8ab8-277a-483c-8cc9-b3de1efe01fa';

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Sticker pack',
                      style: AppleStyles.stickerRowName,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      'Wender Patrick',
                      style: AppleStyles.stickerRowAuthor,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(url,
                        width: 54, height: 54, fit: BoxFit.cover),
                    Image.network(url,
                        width: 54, height: 54, fit: BoxFit.cover),
                    Image.network(url,
                        width: 54, height: 54, fit: BoxFit.cover),
                    Image.network(url,
                        width: 54, height: 54, fit: BoxFit.cover),
                    Image.network(url,
                        width: 54, height: 54, fit: BoxFit.cover),
                  ],
                )
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.down_arrow,
              semanticLabel: 'download',
            ),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext buildContext) {
                  return CupertinoPopupSurface(
                    isSurfacePainted: false,
                    child: CupertinoPageScaffold(
                      child: PackAppleView(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: AppleStyles.productRowDivider,
          ),
        ),
      ],
    );
  }
}
