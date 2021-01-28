import 'package:flutter/material.dart';
import '../database/cruds.dart';
import '../model/todo.dart';
import '../bottomSheet/bottomSheet.dart';

class InitProviders extends ChangeNotifier {
  bool visible = true;
  var count;
  var db = DBCrud();
  List datas = [];
  var returnItems;
  var keys;
  var items;

  bool visibleRead() {
    return visible;
  }

  visibleReturn(bool value) {
    visible = value;
    notifyListeners();
  }

  //henüz kullanılmıyo
  getReturnCountDB() {
    return count;
  }

  //henüz kullanılmıyo
  getCountDB() async {
    count = await db.getCountDB();
    notifyListeners();
  }

  setInputs(var title, var desc) async {
    if ((title != '' && desc != '') || (title != null && desc != null)) {
      var data = TODO(title: title, description: desc);
      await db.insertDB(data);
    }
    notifyListeners();
  }

  updateInputs(int id, var title, var desc) async {
    if ((title != '' && desc != '') || (title != null && desc != null)) {
      var data = TODO(id: id, title: title, description: desc);
      await db.updateDB(data);
    }
    notifyListeners();
  }

  deleteInputs(int id) async {
    if (id != null) {
      await db.deleteDB(id);
    }
    notifyListeners();
  }

  deleteAllInputs() async {
    await db.deleteAllDB();
    notifyListeners();
  }

  Future<List> syncBody(BuildContext context) async {
    var items = await db.getDB();
    if (items != null)
      returnItems = <DataRow>[
        for (int i = 0; i < items.length; i++)
          DataRow(
            cells: <DataCell>[
              DataCell(
                Container(
                  child: Text(
                    items[i].title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                Container(
                  child: Text(
                    items[i].description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                Row(children: [
                  IconButton(
                    iconSize: 20.0,
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => {
                      showData(items[i], context),
                    },
                  ),
                  IconButton(
                    iconSize: 20.0,
                    icon: Icon(Icons.edit_rounded),
                    onPressed: () => {
                      getData(items[i].id, context),
                    },
                  )
                ]),
              ),
            ],
          ),
      ];
    return returnItems;
  }

  getData(id, context) async {
    var data = await db.getEachDB(id);

    displayBottomSheet(
      context,
      data.first.id,
      data.first.title,
      data.first.description,
    );
  }

  showData(data, context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(data.description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('TAMAM'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
