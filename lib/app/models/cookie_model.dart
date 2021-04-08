import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class InstaCookies {
  final String rur;
  final String csrftoken;
  final String ds_user_id;
  final String sessionid;

  InstaCookies({this.rur, this.csrftoken, this.ds_user_id, this.sessionid});

  // static Future<InstaCookies> instance() async {
  //   String csfrToken = (await cookieManager.getCookie(
  //           url: Uri.parse("https://www.instagram.com/"), name: "csrftoken"))
  //       .value;
  //   log("===> csfrtoken is $csfrToken");
  //   // Map cookeis

  //   return InstaCookies(
  //     ig_cb: (await cookieManager.getCookie(
  //                 url: Uri.parse("https://www.instagram.com/"),
  //                 name: "ig_cb")) ==
  //             null
  //         ? ""
  //         : (await cookieManager.getCookie(
  //                 url: Uri.parse("https://www.instagram.com/"), name: "ig_cb"))
  //             .value,
  //     mid: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "mid"))
  //         .value,
  //     ig_did: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "ig_did"))
  //         .value,
  //     shbid: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "shbid"))
  //         .value,
  //     shbts: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "shbts"))
  //         .value,
  //     rur: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "rur"))
  //         .value,
  //     csrftoken: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "csrftoken"))
  //         .value,
  //     ds_user_id: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "ds_user_id"))
  //         .value,
  //     sessionid: (await cookieManager.getCookie(
  //             url: Uri.parse("https://www.instagram.com/"), name: "sessionid"))
  //         .value,
  //   );
  // }
// cookie: ig_cb=2; mid=YGVtHwAEAAFfMoPRhaiuoiInkq6m;
//  ig_did=EEAF15EA-E7C2-4E4C-A03B-FEDB0A3334B1; shbid=13311;
// shbts=1617259848.154815; rur=PRN; csrftoken=1Oqx8zE2j9NQU52tTBryhCXpLLjjZPGS;
// ds_user_id=44812090351; sessionid=44812090351%3AGJYm4XXkUZzKqn%3A15


  Map<String, dynamic> toMap() {
    return {
      'rur': rur,
      'csrftoken': csrftoken,
      'ds_user_id': ds_user_id,
      'sessionid': sessionid,
    };
  }

  factory InstaCookies.fromMap(Map<String, dynamic> map) {
    return InstaCookies(
      rur: map['rur'],
      csrftoken: map['csrftoken'],
      ds_user_id: map['ds_user_id'],
      sessionid: map['sessionid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InstaCookies.fromJson(String source) =>
      InstaCookies.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InstaCookies(rur: $rur, csrftoken: $csrftoken, ds_user_id: $ds_user_id, sessionid: $sessionid)';
  }
}
