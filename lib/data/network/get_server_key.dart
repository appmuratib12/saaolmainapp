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
              "private_key_id": "a1b2990c4075c3dff7e35882ccd76b4f3112a40e",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDWyFU2xH+pDklJ\n0kL/8+3vlYXpLKx2RN9ezRUYWYYop49i9zBKEa2nEtxEuDPXCPXnpYmHewct1RJH\nml/57CI0M7HTkDXCRJa989yO1+ryCaVvtJxHwrlf43Zz+9T/C07GogfVmJMxVIpV\nPqOfyOcrG3fG/mqNf1itA94mygqBPXL0+bdhI8QWjLb4nhQb1aRPi330zXFgrOYH\nckFJ+v0QrdRIfrYQAdg6uc0wgxA23u7p38Ezk/e1s7wQ6bH0BJlHmT+0APM7NrPb\n8Wjf54YjtI3G+KHNt6hMGVYOAZVzlhDpO4Xat+KyC3h73RBLGNi17nUZ2XxKt1bX\nLDEcu+dZAgMBAAECggEAGeqqfaVQUjHrHgFFHGVuvI4qTmyZktvUqDfO59VFnvo5\nDxQMu6NOdO6Nra0cdEIcigsrgTGTODCRuBokop+fsPTb7E9mbT6hgeI/Ju1e6D3J\nvKTqhq40eCGWVYB5vxy6MLW0hE2Y1UcCOi8Ix2sSmd0CovxoFxLavGXPFJcklVuA\nQJx+w9ieoxyc5VmCELQ1V5uxAPJV9Lb0NTGYM9LTFXjfCFGDVCnH/M7EqQDgp+Ml\n93XRQCIWHe7rxBX2ZaW/f+Lq2CH44t/p8h7Iv4rPHuKgCrw+VWh/I2w6wqI4X21y\nmBjNGcMoJsRtIOHzjVsWLH3YXbVpKXKxi3FgfrsuUQKBgQDrI2FEaE4Uw6ivI6jK\nt8Oev8LMYSXh2iAMwPjDnkzf3B9l0ZIUlSmaSWkFt1o4Uk90mAtTxFtlppl2ARb7\nL/p3yB01FFPPDY2oRddshkyOrfz53N/8QRfsoL1F3uhSbTxyyBcRektZTc5HYsCb\n96cE7tW79wKd3VJvXQtPG7KKNwKBgQDp1p8SwCNtbCpXyujf6kbqokR3KBIJRq6+\nualbT2LJao4G1bFWEBwW4fJVh732Cf05fZqm/nUZPriVeIYbAMPpHgfNJavQPfM3\nSa3mIc9S0wWxyEpV/VE+twi7JXwYHE3l8ihM7dFYxVZQ6PiSY83oxMPhSstAW6io\n3VoeeNMS7wKBgQCtoouyIz/9b1qCMlfzkm2/LaXgnKCHvjZKlLleYugrqvX4jyBL\nWLbG+wy1rubNjmKkG57Jtcc0MilCjZ110cEocLq4tpEI5d5Ec4aX2jhwaCTWMfeo\n5DyRfUUncmqma4nmzMDUJDW99YmtB0xqIB/SsbddPRNOld/I4rF2MmLOUwKBgCug\nWg9Cf5mTm5bDiYz1BYQTABkHBc5rPIDi3KDnf7O6SIMn7Sz0VnlCcFbau2si0/ac\n43SSdsBd/kwMr2BsVSCx9JymkZaJaE4BVgtgdXCrZB2WE6BVYYoE1gEsbimFZlcn\nRbOMjwkzz/XKcU3Ghw0NYMowjRkVwLK4kW6r9h1LAoGBAIPVJXQsF1g6oP0t2P9F\neeCcv2/2Nfk9YWT+XjTzyrFsKwWbuAmFOo5XaV83x0JxwMHf/Ta1xI62BzzsvHLv\nEItSbBmGRi/UXthCL5SmLb8OnoRWMfhFIPV7UzX3B2G6XsZiGuer3FfCj2MA1SSf\n559ylZl6Pr+oJRbq/gsGt1CG\n-----END PRIVATE KEY-----\n",
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
