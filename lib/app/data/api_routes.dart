import 'package:insta_mass_agent/app/models/cookie_model.dart';

abstract class API {
  static const base = "https://www.instagram.com/";
  static const Login = base + "accounts/login/ajax/";
  static const ChangeProfilePic = base + "accounts/web_change_profile_picture/";
  static const GetRandomProfilePic = 'https://randomuser.me/api/?results=';
  static const GetEditAccountPage = base + 'accounts/edit/';
  static const Likes = base + "web/likes/";
  static const Save = base + "web/save/";
  static const Comments = base + "web/comments/";
  static const Friendships = base + 'web/friendships/';
  // static const GetMediaId = "https://api.instagram.com/oembed/?url=";
}

abstract class APIHeaders {
  static Map<String, dynamic> friendships(
          InstaCookies cookies, String xAjax, String username) =>
      {
        'accept': '*/*',
        'accept-encoding': 'gzip, deflate, br',
        'accept-language': 'en-US,en;q=0.9,fa;q=0.8',
        'cache-control': 'no-cache',
        'content-length': '0',
        'content-type': 'application/x-www-form-urlencoded',
        'cookie':
            'ig_did=4CF95C11-385F-497D-86B6-81F0D6FA10FF; rur=${cookies.rur}; csrftoken=${cookies.csrftoken}; ds_user_id=${cookies.ds_user_id}; sessionid=${cookies.sessionid}',
        'origin': 'https://www.instagram.com',
        'pragma': 'no-cache',
        'referer': 'https://www.instagram.com/$username',
        'sec-ch-ua':
            '\"Google Chrome\";v=\"89\", \"Chromium\";v=\"89\", \";Not A Brand\";v=\"99\"',
        'sec-ch-ua-mobile': '?0',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'user-agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36',
        'x-csrftoken': cookies.csrftoken,
        'x-ig-app-id': 936619743392459,
        'x-ig-www-claim':
            'hmac.AR0t4GHHbQxberuPUML1Rr8TJrVCs1ourtsUIpilX6HOCUsm',
        'x-instagram-ajax': xAjax,
        'x-requested-with': 'XMLHttpRequest'
      };

  static Map<String, dynamic> likes(
          InstaCookies cookies, String xAjax, String postUrl) =>
      {
        'accept': '*/*',
        'accept-encoding': 'gzip, deflate, br',
        'accept-language': 'en-US,en;q=0.9,fa;q=0.8',
        'cache-control': 'no-cache',
        'content-length': '0',
        'content-type': 'application/x-www-form-urlencoded',
        'cookie':
            'ig_did=4CF95C11-385F-497D-86B6-81F0D6FA10FF; rur=${cookies.rur}; csrftoken=${cookies.csrftoken}; ds_user_id=${cookies.ds_user_id}; sessionid=${cookies.sessionid}',
        'origin': 'https://www.instagram.com',
        'pragma': 'no-cache',
        'referer': postUrl,
        'sec-ch-ua':
            '\"Google Chrome\";v=\"89\", \"Chromium\";v=\"89\", \";Not A Brand\";v=\"99\"',
        'sec-ch-ua-mobile': '?0',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'user-agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36',
        'x-csrftoken': cookies.csrftoken,
        'x-ig-app-id': 936619743392459,
        'x-ig-www-claim':
            'hmac.AR0t4GHHbQxberuPUML1Rr8TJrVCs1ourtsUIpilX6HOCUsm',
        'x-instagram-ajax': xAjax,
        'x-requested-with': 'XMLHttpRequest'
      };
  static Map<String, dynamic> getMediaId(InstaCookies cookies) => {
        'accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'accept-encoding': 'gzip, deflate, br',
        'accept-language': 'en-US,en;q=0.9,fa;q=0.8',
        'cache-control': 'no-cache',
        'cookie':
            'rur=${cookies.rur}; csrftoken=${cookies.csrftoken}; ds_user_id=${cookies.ds_user_id}; sessionid=${cookies.sessionid}',
        'pragma': 'no-cache',
        'sec-ch-ua':
            '\"Google Chrome\";v=\"89\", \"Chromium\";v="89\", \";Not A Brand\";v=\"99\"',
        'sec-ch-ua-mobile': '?0',
        'sec-fetch-dest': 'document',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-user': "?1",
        'upgrade-insecure-requests': 1,
        'user-agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36'
      };

  static Map<String, dynamic> getEditAccountWebpage(InstaCookies cookies) => {
        'accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'accept-encoding': 'gzip, deflate, br',
        'accept-language': 'en-US,en;q=0.9,fa;q=0.8',
        'cache-control': 'no-cache',
        'cookie':
            'ig_nrcb=1; ig_did=E62B7383-6EF7-4D9D-9BDE-4CFD65259E49; mid=YGn_VQAEAAEilsyonIi_plzO0XkV; shbid=6023; rur=ASH; shbts=1617820183.9500425; csrftoken=${cookies.csrftoken}; ds_user_id=${cookies.ds_user_id}; sessionid=${cookies.sessionid}',
        'pragma': 'no-cache',
        'referer': 'https://www.instagram.com/accounts/edit/',
        'sec-ch-ua':
            '\"Google Chrome\";v=\"89\", \"Chromium\";v=\"89\", \";Not A Brand\";v=\"99\"',
        'sec-ch-ua-mobile': "?0",
        'sec-fetch-dest': 'document',
        'sec-fetch-mode': 'navigate',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-user': '?1',
        'upgrade-insecure-requests': 1,
        'user-agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36'
      };

  static Map<String, dynamic> changeProfilePic(
          InstaCookies cookies, contentLen, filename, String xAjax) =>
      {
        'accept': '*/*',
        'accept-encoding': 'gzip, deflate, br',
        'accept-language': 'en-US,en;q=0.9,fa;q=0.8',
        'cache-control': 'no-cache',
        'content-length': contentLen.toString(),
        'dnt': 1,
        "Connection": "keep-alive",
        // "X-IG-App-ID": "936619743392459",
        "Host": "www.instagram.com",

        // "Content-Disposition": "form-data",
        // "name": "profile_pic",
        // "Content-Type": "image/jpeg",
        // "filename": filename,
        // 'content-type':
        //
        //     'multipart/form-data; boundary=----WebKitFormBoundary7jUWr9cBg8n3MrLU',
        'cookie':
            'rur=${cookies.rur}; csrftoken=${cookies.csrftoken}; ds_user_id=${cookies.ds_user_id}; sessionid=${cookies.sessionid}',
        'origin': 'https://www.instagram.com',
        // 'pragma': 'no-cache',
        'referer': 'https://www.instagram.com/accounts/edit/',
        'sec-ch-ua':
            '\"Google Chrome\";v=\"89\", \"Chromium\";v=\"89\", \";Not A Brand\";v=\"99\"',
        'sec-ch-ua-mobile': '?0',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'user-agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36',
        'x-csrftoken': cookies.csrftoken,
        // 'x-ig-app-id': cookies.,
        // 'x-ig-www-claim':
        //     'hmac.AR0t4GHHbQxberuPUML1Rr8TJrVCs1ourtsUIpilX6HOCWoU',
        'x-instagram-ajax': xAjax,
        'x-requested-with': 'XMLHttpRequest'
      };

  static const Map<String, dynamic> loginHeaders = {
    "accept-encoding": "gzip, deflate, br",
    "accept-language": "en-US,en;q=0.9,fa;q=0.8",
    "content-length": 323,
    "content-type": "application/x-www-form-urlencoded",
    "cookie":
        "ig_nrcb=1; ig_did=E62B7383-6EF7-4D9D-9BDE-4CFD65259E49; mid=YGn_VQAEAAEilsyonIi_plzO0XkV; shbid=6023; rur=ASH; shbts=1617820183.9500425; csrftoken=EgERe7iAvnFLIPPAJYyF4cG8fffhuJsj",
    "origin": "https://www.instagram.com",
    "referer": "https://www.instagram.com/accounts/login/",
    "sec-ch-ua":
        '\"Google Chrome\";v=\"89\", \"Chromium\";v=\"89\", \";Not A Brand\";v=\"99\"',
    "sec-ch-ua-mobile": '?0',
    "sec-fetch-dest": 'empty',
    "sec-fetch-mode": 'cors',
    "sec-fetch-site": "same-origin",
    "user-agent":
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36",
    "x-csrftoken": "EgERe7iAvnFLIPPAJYyF4cG8fffhuJsj",
    "x-ig-app-id": "936619743392459",
    "x-ig-www-claim": "hmac.AR0t4GHHbQxberuPUML1Rr8TJrVCs1ourtsUIpilX6HOCWoU",
    "x-instagram-ajax": "3de2d7ec996d",
    "x-requested-with": "XMLHttpRequest",
  };
}
