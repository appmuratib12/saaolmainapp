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
              "private_key_id": "078bb7628ce6624cbad33571c63ac82361139a86",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDNqCcYTAY9amG0\nhQX4Gf6lrq+xTv8Jl0/sqFHGio3PKAjh2vrKIwZTKoE0pO1ngIzPvcJTW5rR0ZlV\nJbOD5rEoC4cWdOQU9O+FJ8QcvaA29ca/p3bC7SI9wn2FiOA6xNRcbCIs68wsxBOK\nv7k/s+YA75W7ziD/upNtU5vdS+OV6l+yEdKOjTgNDc82Eshy51HNgKc+vFQUlP8z\nyxkuvVbswUpFKEY4C6HOPcUaMY2QoSRWoh6hC4ar6ZPerOcc/8WCOtlPYM3yFsnk\nViAkrPXtPgMy8ZgZSLettOC3wbmOp0qOoDdF1Prf1/swAsqiXWaum8A8rFgE82Hp\nXy4Slg4JAgMBAAECggEADj++E7IixYsTIXONBhNhACBCFo4jYAn+lOZVoiSz7hw3\nP1TRhwNVuxnpEVlzBHaU6wjaB7YDXFHCJrLhxPwNHrnrvmvTaLtOxCJM9XPS/7PY\nNSu4cAmHk5Ff6ophBNlh4FRyqrucriZYt0aQ4n/Hqh1vea9uvGE0OUEvfa32IwsW\nEeaUY8+9+exkSIlKtrPiwea6KPwiWhWa2KpRx+R2kmwGqqeEhMWKZmm0j1piBifF\nZLCPssti2y4LccDNL5Gta95mcAiCxcL8aWqQLqVJbDtuTH+vZPxxfvJ7qhDtkwfm\nd60V0+L8JJjKS5hpJy7ftMJH0XozXdN6Y4Dl7YkS4QKBgQDm+5iDnyncpODNIvfm\nbhibB2BO6+7E3WuUPjbDDV77dBG2OGppgWC16wgUY37xAzp1hU8mJAbBGGj+2095\nOL20AUGkhmc0NXFq2cAte10zVfIbXSMHwyM77DG366zbESpRGHr992+OZZLk1CaJ\n/xNGAYKVaIZXo+uPKbfSes87mQKBgQDj7lm4Vy/ztCcwgZozBUuQ6e1ukRzWK133\nYe3lgK0wuqD/4JZGWasRGZENjSoHHo8IbusSWJC1XRpOBBkdwdGQ373O9JYo+pr1\nrPwoAv9GstFAtJ1zP+2rfIGlG9LQXqaRU43ndeZYY2JPvo2a0uZJrxYeVygVCkmB\niWMzQgZr8QKBgQCH02cp7wxkzSfMOUXhYNhjQYEmp6JubW33bGYzaMdzwhswNhiN\nFiFSmHTV2HQrMaTMuqmCWikGn14Oj9Q6Cl2zXhHFt6s0jkC1fnp9xE9YArAt2yTg\nSaWMdSX/azzoTT2/FlAsy7Xz3FL28LIA79fbkMPDLAXjv2ajdvq7cLAv8QKBgBjb\nRmeHApC2JcvxZkqIGkyMZjs3kgh9JDs1L8dmd/ynbaVZ7alwX+p2ek4bBelO2NRX\nnEUc6XMN2y+E3ORU3bDJ5Z4rKDEB22JNYhZO9V3VZGKFD+Kgpx+bbVv/I8dbexjA\nHuqN/ffHptIBetnWhAynDmdyo8lfnNKGlA3j9mVRAoGAHf1e5Ru68p2zfV3im8F/\n1oRSGp0uEdokIz4WaIiCLN4u8STBZ6Fq0FkFAAk+RG3RH+4I2Pv77Z3bMMhSGxFS\nyUAZK73LxSc3MEvbFLYBoPszvTydmrYYYWjRpPM6vdu2SHqEGigaCRbHKeS8m8w9\nIctmVtiAZmayTkTY6vuG8PE=\n-----END PRIVATE KEY-----\n",
              "client_email": "firebase-adminsdk-fbsvc@saaolapp-4918b.iam.gserviceaccount.com",
              "client_id": "115862860914564928487",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40saaolapp-4918b.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
        ),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}
