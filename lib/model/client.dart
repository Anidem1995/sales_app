class Client {
  int id;
  String name;
  String address;
  String email;
  String phone;

  Client({this.id, this.name, this.address, this.email, this.phone});

  factory Client.fromJson(Map jsonMap) {
    return Client(
      id: jsonMap['id'],
      name: jsonMap['name'],
      address: jsonMap['address'],
      email: jsonMap['email'],
      phone: jsonMap['phone']
    );
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['email'] = email;
    map['phone'] = phone;

    return map;
  }
}

class ClientsList {
  List<Client> clients;

  ClientsList({this.clients});

  factory ClientsList.fromJson(List<dynamic> jsonList) {
    List<Client> clients = List<Client>();
    clients = jsonList.map((i) => Client.fromJson(i)).toList();
    return ClientsList(clients: clients);
  }
}