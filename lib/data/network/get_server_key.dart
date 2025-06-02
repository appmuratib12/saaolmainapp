import 'package:googleapis_auth/auth_io.dart';
class get_server_key {
  Future<String> server_token() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "saaolapp-4918b",
          "private_key_id": "77e5103348fe2589bba138334c776a49a65fc190",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBPShjOVtXOPFk\nC+lGVspojGsXshv/AyaD0+iGWju3QNkEMwwD+yfyMqFDb9xjQyCIU0TSeZFBGR+f\nerIz58wSg22OyK64b55Q4UmmcodCgbha1t4YJ+AFwBVjpub08sfei3ziFUyTWb7F\nVHVt9uApsqVNVGW2RqdGT37UAgYHpwNO+nbwwlN6Cu6s3jYTCdNNYJkdnFtdXbVe\nEVksRHydNcL7QPadxSlhUDmfFm7kJo9hpYz6YzLZoTS92rN+ZSONlfMIG+rO4cY/\nsDTOAbHaae3/lKBXpnbRyRUtmA8ddFtZkj300yLtalShdYbNd36k/yH3x2opwJ43\nVDI1Cb+fAgMBAAECggEAA8nT/QoBU+xDsz9BM1tSkYp7M6uOvUj4XCpEiz8Wn55F\nAujl9JKxHaBHer/P1XRZ8sJAfaiGI/1pmiH41L1XygnLP+WITgkGKgtt+wuQwkmH\nwzl7gNll8hw/bxo1D0VOjNA1l7sXgBCzhZaFIi2ZBx2U/GH0soZKaOhNvLtOF0qd\nXPEN7JS1E5HEZhf5CzGp01jXK2nokjCiAS/Nr8W4PFsI57bm/vsd0fRJKuzPDyDT\nzAm2Xonv5PCyP5FHbeEx9MMMoEkRIe8NUXqvZ0LQQ8cXp3ADlet8Gy47D7EYBs6c\nCP3aHj+jX3EsSwzS22BQhofFIWIzfkDvVhVUZwH8JQKBgQDoyJosdLWXadnwk6uv\nFHsnKoITjdglrXNn93aNlLcy/315MxfttEAZRE2Ik7n7h2H0E5MPOA0xnLK/jBX4\nx/P9ZZYnB1DoSDLfVM9ziaGyc71aT096dkFZndBKTHgq8NvhZxWpXBmqb+aM3xeE\nCrGIXz2BKdd1PCtlxbHW2ciOGwKBgQDUguffXKzde1FxbJMrEyNfp//99MT5/i3O\n+x2X58SLQNEK5x2Av+vIEjrjaXokRgsOOzVPyFGZ/FtxH6op5PmIl9eruYYFJj5o\n4xtKbTXzhxSQhyAM0lZ21N0VA9REOzaT3MqH5B8yEs77jWkWac7qHbcRtsqwVFez\nk0YkKf8czQKBgQCrlIEfV38p9dmwXAhl6mDEA68RHrI9Q1YXQe3eecl3C56+oQx4\nJy4/8Xp8uvaREb7/mxYAV75R3UBbs7PWRfvvwNsmNVxLejwVJXwrmzzWPj1Jvb/F\ncjjFB2+p9Cd270YDJGpxBPPeDtEO8LlymDc3X4wEEoU/YnRSdZ+Zz7jmFQKBgC6E\nwVEprkWFWxyjEcwaEmI8GlNzIzM+KrTmT2ITP/jjpV7nnJO0b16Kbw2c5znNg1oI\nJ/Fg/kvg6/tlXRByqRT3eCSFJgs2he7b1/uA0JCQfzXr/l4QJRE6I3MYNX0CIT5Y\n1JTOoO2LJHf4Soq3eq3Q92QPSWsz60bJ9E6ySr/5AoGAMtZ1gNu9z9JU8XlhAn3g\n8VC4dFNkWN7j3mpBDWHWFt6zyMyTDRwNOrVsk/J1oEZmf4ejlhRCZiqWmO9LJiLa\nJZxzj90H0MiFu+pySooLWMNRBo2QZqDGb9SYNSan+r9Wk9gjt8FdGrvKiOwCEpbE\nu6j/R7uChCiN0aD4CcOyq8Q=\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-fbsvc@saaolapp-4918b.iam.gserviceaccount.com",
          "client_id": "115862860914564928487",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40saaolapp-4918b.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}
