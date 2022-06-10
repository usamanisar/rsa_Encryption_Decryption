class MyKey {
  String publickey;
  String privatekey;
  String name;
  String personalname;
  String expiryDate;

  MyKey({this.publickey, this.privatekey, this.name, this.personalname, this.expiryDate});

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['publickey'] = publickey;
    m['privatekey'] = privatekey;
    m['name'] = name;
    m['personalname'] = personalname;
    m['expiryDate'] = expiryDate;

    return m;
  }
  Map<String, String> toJSON() {
    Map<String, String> m = new Map();

    m['publickey'] = publickey;
    m['privatekey'] = privatekey;
    m['name'] = name;
    m['personalname'] = personalname;
    m['expiryDate'] = expiryDate;



    return m;
  }
  MyKey.fromJsonEncodable(Map<String,dynamic> a){
    this.publickey = a["publickey"];
    this.privatekey =a["privatekey"];
    this.name = a["name"];
    this.personalname = a["personalname"];
    this.expiryDate= a['expiryDate'] ;

  }


}

class MyKeyList {
  List<MyKey> items = [];

  List<Map<String, dynamic>>  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
