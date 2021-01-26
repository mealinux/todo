import '../provider/provider.dart';
import 'package:flutter/material.dart';
import '../bottomSheet/bottomSheet.dart';
import 'package:provider/provider.dart';

class BarState extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Bar createState() => Bar();
}

class Bar extends State<BarState> {
  Bar({this.count = 0, this.visible = true});

  final visible;
  var count;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Yapılacak Listesi'),
      actions: <Widget>[
        Consumer<InitProviders>(
            builder: (context, initProvidersIconObject, child) {
          return Row(
            children: [
              Visibility(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete_sweep),
                      tooltip: 'All Clear',
                      onPressed: () => {
                        allClearAlert(initProvidersIconObject),
                      },
                    ),
                  ],
                ),
                visible: false,
              ),
              Visibility(
                child: IconButton(
                  icon: Icon(Icons.add),
                  tooltip: 'Yapılacak Ekle',
                  onPressed: () => {
                    displayBottomSheet(context, null, '', ''),
                    initProvidersIconObject.visibleReturn(false)
                  },
                ),
                visible: initProvidersIconObject.visibleRead(),
              )
            ],
          );
        })
      ],
    );
  }

  allClearAlert(initProvidersIconObject) async {
    // daha sonra ki güncellemede
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uyarı'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tüm kayıtları silmek istediğine emin misin?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İPTAL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('TÜMÜNÜ SİL'),
              onPressed: () {
                initProvidersIconObject.deleteAllInputs();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
