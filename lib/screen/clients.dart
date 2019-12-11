import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales/model/client.dart';
import 'package:random_color/random_color.dart';
import 'package:sales/screen/create_client.dart';
import 'package:sales/net/httphandler.dart';

import 'create_client.dart';

class Clients extends StatefulWidget {
  Clients({Key key}) : super(key: key);
  
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  List<Client> clients = List();

  @override
  void initState() {
    super.initState();
    getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clients'),),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: clients.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            key: Key(clients.elementAt(index).id.toString()),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: RandomColor().randomColor(),
                  child: Text(clients.elementAt(index).name.split(" ")[0].substring(0,1) + clients.elementAt(index).name.split(" ")[1].substring(0,1)),
                  foregroundColor: Colors.white,
                ),
                title: Text(clients.elementAt(index).name, style: TextStyle(fontSize: 20.0),),
                subtitle: Text(clients.elementAt(index).email, style: TextStyle(fontSize: 18.0),),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: ()=> setState(() {
                  clients.removeAt(index);
                }),
              )
            ],
            dismissal: SlidableDismissal(
              child: SlidableDrawerDismissal(),
              onDismissed: (actionType) {
                setState(() {
                  clients.removeAt(index);
                });
              },
              dismissThresholds: <SlideActionType, double> {
                SlideActionType.primary: 1.0
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateClient())
        )
        },
      ),
    );
  }

  Future getClients() async {
    var clientss = await HttpHandler().clientsList();
    String tunas = "";
    setState(() {
      clients.addAll(clientss);
    });
  }
}
