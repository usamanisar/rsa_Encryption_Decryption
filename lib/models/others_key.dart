class OthersKey {
  String publickey;
  String name;
  String expiryDate;

  OthersKey({this.publickey, this.name, this.expiryDate} );

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['publickey'] = publickey;
    m['name'] = name;
    m['expiryDate'] = expiryDate;

    return m;
  }
  Map<String, String> toJSON() {
    Map<String, String> m = new Map();

    m['publickey'] = publickey;
    m['name'] = name;
    m['expiryDate'] = expiryDate;



    return m;
  }
  OthersKey.fromJsonEncodable(Map<String,dynamic> a){
    this.publickey = a["publickey"];
    this.name = a["name"];
    this.expiryDate = a["expiryDate"];

  }


}

class OthersKeyList {
  List<OthersKey> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
