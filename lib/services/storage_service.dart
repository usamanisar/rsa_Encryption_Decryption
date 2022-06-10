import 'package:localstorage/localstorage.dart';
import 'package:rsa_text_encryption/models/my_key_model.dart';
import 'package:rsa_text_encryption/models/others_key.dart';

class StorageService {
  final LocalStorage keyStorage = LocalStorage('key_storage');

  String my_keys = "my_keys";
  String others_keys = "others_keys";

  StorageService();

  List<MyKey> getMyKeys() {
    var items = keyStorage.getItem(my_keys);
    if (items == null) {
      return null;
    } else {
      return List<MyKey>.from(
        (items as List).map((item) => MyKey(
            publickey: item['publickey'],
            privatekey: item['privatekey'],
            name: item['name'],
            expiryDate: item['expiryDate'],
            personalname: item['personalname'])),
      );
    }
  }

  List<OthersKey> getOthersKeys() {
    var items = keyStorage.getItem(others_keys);
    if (items == null) {
      return null;
    } else {
      return List<OthersKey>.from(
        (items as List).map((item) =>
            OthersKey(publickey: item['publickey'], name: item['name'],expiryDate: item['expiryDate'],)),
      );
    }
  }

  addMyKey(MyKey item) {
    final MyKeyList list = new MyKeyList();

    List<MyKey> items = getMyKeys();
    if (items != null) {
      list.items = items;
    } else {
      list.items = [];
    }
    list.items.add(item);
    keyStorage.setItem(my_keys, list.toJSONEncodable());
  }

  addOtherKey(OthersKey item) {
    final OthersKeyList list = new OthersKeyList();

    List<OthersKey> items = getOthersKeys();
    if (items != null) {
      list.items = items;
    } else {
      list.items = [];
    }
    list.items.add(item);
    keyStorage.setItem(others_keys, list.toJSONEncodable());
  }

  void deleteMyKey(int item) {
    final MyKeyList list = new MyKeyList();

    List<MyKey> items = getMyKeys();
    if (items != null) {
      list.items = items;
    } else {
      list.items = [];
    }
    list.items.removeAt(item);
    keyStorage.setItem(my_keys, list.toJSONEncodable());
  }
  void deleteOthersKey(int item) {
    final OthersKeyList list = new OthersKeyList();

    List<OthersKey> items = getOthersKeys();
    if (items != null) {
      list.items = items;
    } else {
      list.items = [];
    }
    list.items.removeAt(item);
    keyStorage.setItem(others_keys, list.toJSONEncodable());
  }
}
