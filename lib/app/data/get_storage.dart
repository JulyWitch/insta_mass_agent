import 'dart:developer';

import 'package:insta_mass_agent/app/models/cookie_model.dart';
import 'package:get_storage/get_storage.dart';

class MyStorage {
  final box = GetStorage();
  // saveMe(i) {
  //   box.write(i.toString(), i);
  // }

  // readMe(i) {
  //   box.read(i.toString());
  // }

  writeCookies(InstaCookies cookies, String username) async {
    log('read Cookie ===> ${cookies.toJson()}');
    box.write('cookies$username', cookies.toJson());
  }

  Future<InstaCookies> readCookies(String username) async {
    log('read Cookie ===> ${box.read('cookies')}');
    var co = box.read('cookies$username');
    if (co == null) return null;
    return InstaCookies.fromJson(co);
  }

  removeCookies(String username) {
    box.remove("cookies$username");
  }
}
