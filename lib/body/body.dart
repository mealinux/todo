import '../provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyState extends StatefulWidget {
  @override
  BodyState({Key key}) : super(key: key);

  @override
  Body createState() => Body();
}

class Body extends State<BodyState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitProviders>(
      builder: (context, initProvidersDataTableObject, child) {
        return FutureBuilder(
          future: initProvidersDataTableObject.syncBody(context),
          builder: (context, snapshot) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text('Başlık')),
                  DataColumn(label: Text('Detay')),
                  DataColumn(label: Text('')),
                ],
                rows: snapshot.hasData ? snapshot.data : ifEmpty(),
              ),
            );
          },
        );
      },
    );
  }
}

ifEmpty() {
  return <DataRow>[
    DataRow(
      cells: <DataCell>[
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
      ],
    )
  ];
}
