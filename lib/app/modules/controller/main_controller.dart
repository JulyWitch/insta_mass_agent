import 'dart:developer';
import 'dart:io';

import 'package:insta_mass_agent/app/data/api_provider.dart';
import 'package:insta_mass_agent/app/data/api_routes.dart';
import 'package:insta_mass_agent/app/data/get_storage.dart';
import 'package:insta_mass_agent/app/models/cookie_model.dart';
import 'package:insta_mass_agent/app/utils/const_data.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class MainController extends GetxController {
  MyStorage storage = MyStorage();
  Map<String, InstaCookies> cookies = {};
  Map<String, String> env = Platform.environment;

  MainController() {
    appPath = env['HOME'] + '/insta-mass-agent/';
    avatarsPath = appPath + 'avatars/';

    login();
  }
  login() async {
    for (String username in ConstDatas.usernames) {
      // storage.removeCookies(username);

      InstaCookies cookie = await storage.readCookies(username);
      if (cookie != null)
        cookies.addAll({username: cookie});
      else {
        dio.Response res = await ApiProvider.login(username: username);
        cookie = InstaCookies(
          csrftoken:
              res.headers.map['set-cookie'][0].split(';').first.split('=').last,
          rur:
              res.headers.map['set-cookie'][1].split(';').first.split('=').last,
          ds_user_id:
              res.headers.map['set-cookie'][2].split(';').first.split('=').last,
          sessionid:
              res.headers.map['set-cookie'][3].split(';').first.split('=').last,
        );
        cookies.addAll({username: cookie});
        storage.writeCookies(cookie, username);
      }
      log(username + " Cookie ===> " + cookie.toString());
    }
  }

  String appPath;
  String avatarsPath;

  changeProfilePhotos() async {
    createAppDir();
    var res =
        await ApiProvider.getRandomProfilePhotos(ConstDatas.usernames.length);
    for (var m in res['results']) {
      String url = m['picture']['medium'];
      // log(m['picture']['medium']);
      await dio.Dio().download(
        url,
        avatarsPath +
            ConstDatas.usernames[res['results'].indexOf(m)].toString() +
            ".jpg",
        onReceiveProgress: (count, total) => log(avatarsPath +
            ConstDatas.usernames[res['results'].indexOf(m)].toString() +
            ".jpg" +
            " Downloaded and Saved"),
      );
    }
    for (String username in ConstDatas.usernames) {
      await ApiProvider.changeProfilePic(
          cookies: cookies[username], pic: avatarsPath + username + ".jpg");
    }
  }

  createAppDir() {
    Directory(appPath).create().then((value) => log("Dir created ===> $value"));
    Directory(avatarsPath);
  }

  likePost(String postUrl) async {
    String id =
        await ApiProvider.getMediaId(cookies[ConstDatas.usernames[0]], postUrl);
    log("Going to like $postUrl with id $id");
    for (var username in ConstDatas.usernames) {
      String xAjax = await ApiProvider.findAjax(cookies[username], postUrl);
      var res = await ApiProvider.likes(
          cookies[username], id, 'like', xAjax, postUrl);
      log(res.toString());
    }
  }

  savePost(String postUrl) async {
    String id =
        await ApiProvider.getMediaId(cookies[ConstDatas.usernames[0]], postUrl);
    log("Going to save $postUrl with id $id");
    for (var username in ConstDatas.usernames) {
      String xAjax = await ApiProvider.findAjax(cookies[username], postUrl);
      var res = await ApiProvider.save(cookies[username], id, xAjax, postUrl);
      log(res.toString());
    }
  }

  addComment(String postUrl, String commentText) async {
    String id =
        await ApiProvider.getMediaId(cookies[ConstDatas.usernames[0]], postUrl);
    log("Going to comment $commentText on $postUrl with id $id");
    for (var username in ConstDatas.usernames) {
      String xAjax = await ApiProvider.findAjax(cookies[username], postUrl);
      var res = await ApiProvider.addComment(
          cookies[username], id, xAjax, postUrl, commentText);
      log(res.toString());
    }
  }

  follow(String username) async {
    String id = await ApiProvider.getUserid(username);
    log("Going to follow $username with id $id");
    for (var user in ConstDatas.usernames) {
      String xAjax =
          await ApiProvider.findAjax(cookies[user], API.base + username);
      var res = await ApiProvider.friendships(
          cookies[user], id, username, xAjax, 'follow');
      log(res.toString());
    }
  }

  debug() async {
    follow('sajad.dev');
    // addComment('https://www.instagram.com/p/CNLcpyHld4x/', 'Awlieeee');
    // savePost('https://www.instagram.com/p/CNLcpyHld4x/');
    // likePost('https://www.instagram.com/p/CNLcpyHld4x/');
    // changeProfilePhotos();
    // String path = env['HOME'] + '/insta-mass-agent/';
    // String savePath = path + 'avatars/';
    // Directory(path).create().then((value) => log("Dir created ===> $value"));
    // Directory(savePath)
    //     .create()
    //     .then((value) => log("Dir created ===> $value"));
    // var res = await ApiProvider.getRandomProfilePhotos(20);
    // // log(res.toString());
    // for (var m in res['results']) {
    //   String url = m['picture']['medium'];
    //   // log(m['picture']['medium']);
    //   dio.Dio().download(
    //     url,
    //     savePath + res['results'].indexOf(m).toString() + ".jpg",
    //     onReceiveProgress: (count, total) => log(url + " Downloaded and Saved"),
    //   );
    // }
    // // for()
  }
}
