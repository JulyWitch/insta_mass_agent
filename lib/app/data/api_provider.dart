import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart' as hp;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_mass_agent/app/data/api_routes.dart';
import 'package:insta_mass_agent/app/error_handler/error_handler.dart';
import 'package:insta_mass_agent/app/models/cookie_model.dart';
import 'package:insta_mass_agent/app/utils/const_data.dart';
import 'package:persian_date/persian_date.dart';

abstract class ApiProvider {
  static Future login({@required username}) async {
    try {
      Response res = await Dio().post(API.Login,
          data: FormData.fromMap({
            "username": username,
            "enc_password":
                "#PWD_INSTAGRAM_BROWSER:0:${DateTime.now().millisecondsSinceEpoch / 1000}:${ConstDatas.password}"
          }),
          options: Options(headers: APIHeaders.loginHeaders));
      if (res.statusCode == 200) {
        // log("Login ===> " + res.toString());
        return res;
      }

      ErrorHandler.Error500();
    } catch (e) {
      log(e.toString());
      ErrorHandler.Error500();
    }
    return null;
  }

  static Future friendships(
      InstaCookies cookies, String id, String username, String xAjax, String act) async {
    try {
      Response res = await Dio().post(API.Friendships + id + '/$act/',
          options: Options(
              headers: APIHeaders.friendships(cookies, xAjax, username),
              method: 'POST',
              extra: {
                'authority': 'www.instagram.com',
                'method': 'POST',
                'path': '/web/friendships/' + id + '/$act/',
                'scheme': 'https'
              }));
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      log("comment ==> $e");
    }
  }

  static Future getUserid(String username) async {
    try {
      Response res = await Dio().get(API.base + username + '/?__a=1');
      if (res.statusCode == 200) return res.data['graphql']['user']['id'];
    } catch (e) {
      log("Get userid ===> $e");
    }
  }

  static Future addComment(InstaCookies cookies, String id, String xAjax,
      String postUrl, String commentText) async {
    try {
      Response res = await Dio().post(API.Comments + id + '/add/',
          data: FormData.fromMap({
            'comment_text': commentText,
            'replied_to_comment_id': '',
          }),
          options: Options(
              headers: APIHeaders.likes(cookies, xAjax, postUrl),
              method: 'POST',
              extra: {
                'authority': 'www.instagram.com',
                'method': 'POST',
                'path': '/web/comments/' + id + '/add/',
                'scheme': 'https'
              }));
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      log("comment ==> $e");
    }
  }

  static Future save(
      InstaCookies cookies, String id, String xAjax, String postUrl) async {
    try {
      Response res = await Dio().post(API.Save + id + '/save/',
          options: Options(
              headers: APIHeaders.likes(cookies, xAjax, postUrl),
              method: 'POST',
              extra: {
                'authority': 'www.instagram.com',
                'method': 'POST',
                'path': '/web/save/' + id + '/save/',
                'scheme': 'https'
              }));
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      log("saves ==> $e");
    }
  }

  static Future likes(InstaCookies cookies, String id, String like,
      String xAjax, String postUrl) async {
    try {
      Response res = await Dio().post(API.Likes + id + '/' + like + '/',
          options: Options(
              headers: APIHeaders.likes(cookies, xAjax, postUrl),
              method: 'POST',
              extra: {
                'authority': 'www.instagram.com',
                'method': 'POST',
                'path': '/web/likes/' + id + '/$like/',
                'scheme': 'https'
              }));
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      log("likes ==> $e");
    }
  }

  static Future getMediaId(InstaCookies cookies, String postUrl) async {
    String id = "";
    try {
      Response res = await Dio().get(postUrl,
          options: Options(headers: APIHeaders.getMediaId(cookies)));

      if (res.statusCode == 200) {
        // log("Login ===> " + res.toString());
        // return res.data;
        // log(res.data);
        final regex = RegExp(r'media\?id=\d*');
        id = regex.firstMatch(res.data).group(0);
        id = id.replaceAll('media?id=', '');
        // .splitMapJoin(
        //       RegExp(r'"rollout_hash":"[a-z,A-z,0-9]*"'),
        //       onMatch: (m) => m[0],
        //     );
        return id;
      }
    } catch (e) {
      log("Get mediaid ==> $e");
    }
  }

// files = {'profile_pic': open(p_pic,'rb')}
// values = {"Content-Disposition": "form-data", "name": "profile_pic", "filename":"profilepic.jpg",
// "Content-Type": "image/jpeg"}

  static Future findAjax(InstaCookies cookies, String postUrl) async {
    String xAjax = "";
    try {
      Response res = await Dio().get(postUrl,
          options: Options(headers: APIHeaders.getEditAccountWebpage(cookies)));

      if (res.statusCode == 200) {
        // log("Login ===> " + res.toString());
        // return res.data;
        // log(res.data);
        final regex = RegExp(r'\"rollout_hash\":\"[a-z,A-z,0-9]*\"');
        xAjax = regex.firstMatch(res.data).group(0);
        xAjax = xAjax.replaceAll('"', '');
        xAjax = xAjax.replaceAll('rollout_hash', '');
        xAjax = xAjax.replaceAll(':', '');
        return xAjax;
        // .splitMapJoin(
        //       RegExp(r'"rollout_hash":"[a-z,A-z,0-9]*"'),
        //       onMatch: (m) => m[0],
        //     );
      }
    } catch (e) {
      log("Get Ajax ==> $e");
    }
  }

  static Future changeProfilePic(
      {@required InstaCookies cookies, String pic}) async {
    String xAjax = "";
    var pict = File(pic);
    String filename = pic.split('/').last;
    var imageBytes = await MultipartFile.fromFile(pic,
        contentType: hp.MediaType.parse('image/jpeg'));
    var contentLen = imageBytes.length;

    try {
      Response res = await Dio().get(API.GetEditAccountPage,
          options: Options(headers: APIHeaders.getEditAccountWebpage(cookies)));

      if (res.statusCode == 200) {
        // log("Login ===> " + res.toString());
        // return res.data;
        // log(res.data);
        final regex = RegExp(r'\"rollout_hash\":\"[a-z,A-z,0-9]*\"');
        xAjax = regex.firstMatch(res.data).group(0);
        xAjax = xAjax.replaceAll('"', '');
        xAjax = xAjax.replaceAll('rollout_hash', '');
        xAjax = xAjax.replaceAll(':', '');
        // .splitMapJoin(
        //       RegExp(r'"rollout_hash":"[a-z,A-z,0-9]*"'),
        //       onMatch: (m) => m[0],
        //     );

        try {
          Response res = await Dio().post(API.ChangeProfilePic,
              data: FormData.fromMap({
                'profile_pic': imageBytes,
              }),

              // queryParameters: {
              //   "Content-Disposition": "form-data",
              //   "name": "profile_pic",
              //   "Content-Type": "image/jpeg",
              //   "filename": filename,
              // },
              options: Options(
                  contentType: "image/jpeg",
                  extra: {
                    "Content-Disposition": "form-data",
                    "name": "profile_pic",
                    "filename": filename,
                  },
                  headers: APIHeaders.changeProfilePic(
                      cookies, contentLen, filename, xAjax)));
          if (res.statusCode == 200) {
            // log("Login ===> " + res.toString());
            return res;
          }

          ErrorHandler.Error500();
        } catch (e) {
          log("Change avatar error ===> " + e.toString());
          ErrorHandler.Error500();
        }
      }

      ErrorHandler.Error500();
    } catch (e) {
      log(e.toString());
      ErrorHandler.Error500();
    }
    return null;
  }

  static Future getRandomProfilePhotos(int quantity) async {
    try {
      Response res =
          await Dio().get(API.GetRandomProfilePic + quantity.toString());
      if (res.statusCode == 200) {
        // log("Login ===> " + res.toString());
        return res.data;
      }

      ErrorHandler.Error500();
    } catch (e) {
      log(e.toString());
      ErrorHandler.Error500();
    }
    return null;
  }
}
