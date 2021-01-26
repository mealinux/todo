import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

void displayBottomSheet(
  BuildContext context,
  int id,
  String title,
  String desc,
) {
  var _title = TextEditingController();
  var _desc = TextEditingController();
  _title.text = title;
  _desc.text = desc;
  showBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<InitProviders>(
          builder: (context, initProvidersDoneObject, child) {
            return FutureBuilder(
                future: initProvidersDoneObject.getCountDB(),
                builder: (context, snapshot) {
                  return WillPopScope(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 2.0, color: Colors.lightGreen),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height / 1.60,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      initProvidersDoneObject
                                          .visibleReturn(true);
                                      if (id != null) {
                                        customAlertDialog(
                                            initProvidersDoneObject,
                                            id,
                                            context,
                                            'Uyarı',
                                            'Silmek istediğinize emin misiniz?',
                                            'SİL');
                                      }
                                    },
                                  ),
                                  visible: id != null ? true : false,
                                ),
                                Visibility(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      if (_title.text == '' ||
                                          _desc.text == '') {
                                        customAlertDialog(
                                            null,
                                            null,
                                            context,
                                            'Oops! Hata',
                                            'Lütfen boş alan bırakmayın',
                                            'TAMAM');
                                      } else {
                                        Navigator.pop(context);
                                        initProvidersDoneObject
                                            .visibleReturn(true);
                                        if (id != null) {
                                          initProvidersDoneObject.updateInputs(
                                            id,
                                            _title.text,
                                            _desc.text,
                                          );
                                        } else {
                                          initProvidersDoneObject.setInputs(
                                            _title.text,
                                            _desc.text,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  visible: true,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: _title,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.lightBlue),
                                ),
                                labelText: 'Başlık',
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: _desc,
                              minLines: 6,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.lightBlue),
                                ),
                                labelText: 'Detay',
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // ignore: missing_return
                    onWillPop: () {
                      Navigator.pop(context);
                      initProvidersDoneObject.visibleReturn(true);
                    },
                  );
                });
          },
        );
      });
}

customAlertDialog(
  var initProvidersDoneObject,
  int id,
  var context,
  String title,
  String description,
  String buttonText,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description),
            ],
          ),
        ),
        actions: [
          Visibility(
            child: TextButton(
              child: Text("İPTAL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            visible: id != null ? true : false,
          ),
          TextButton(
            child: Text(buttonText),
            onPressed: () {
              if (id != null) {
                initProvidersDoneObject.deleteInputs(id);
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
