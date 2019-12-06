import 'package:flutter/material.dart';
import 'package:sales/net/httphandler.dart';
import 'package:sales/model/product.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sales/screen/login.dart';
import 'package:sales/screen/clients.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Product> products = List();

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    String name = 'José';
    return MaterialApp(
      title: 'Listado de productos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Home'),),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('José'),
                accountEmail: Text('14030732@itcelaya.edu.mx'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1194966051198504960/yRNJ193e_400x400.jpg'),
                ),
              ),
              ListTile(
                title: Text('Products'),
                leading: Icon(Icons.local_grocery_store),
                onTap: () {
                } ,
              ),
              ListTile(
                title: Text('Clients'),
                leading: Icon(Icons.contacts),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Clients())
                  );
                },
              ),
              ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.exit_to_app),
                onTap: () => logout(),
              )
            ],
          ),
        ),
        body: Center(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: products.length,
            itemBuilder: (BuildContext, int index) {
                return Slidable(
                  key: Key(products.elementAt(index).product_id.toString()),
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(products.elementAt(index).image)
                      ),
                      title: Text(products.elementAt(index).name, style: TextStyle(fontSize: 20.0),),
                      subtitle: Text('\$' + products.elementAt(index).price.toString(), style: TextStyle(fontSize: 18.0),),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: ()=> setState(() {
                        products.removeAt(index);
                      }),
                    )
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                    onDismissed: (actionType) {
                      setState(() {
                        products.removeAt(index);
                      });
                    },
                    dismissThresholds: <SlideActionType, double> {
                      SlideActionType.primary: 1.0
                    },
                  ),
                );
            },
          ),
        )
      )
    );
  }

  void getProducts() async {
    var productss = await HttpHandler().productsList();
    String tunas = "";
    setState(() {
      products.addAll(productss);
    });
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder:(context) => Login()),
            (Route<dynamic> route) => false
    );
  }
}