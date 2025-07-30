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
              "private_key_id": "5a5b61aeda14d0c549c7b94dfb42e8c3dbf79bf8",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC7eigCMEDCdy3S\n6GlymNeKiVeIbBvVd8rAFq7h8Rh23tGhdZNBWZDCmOnyDsWUyo2Ebflkhp8LpiFJ\nqcLDBwW4aNcEicTLxE5S+OjomLb5qVFTTf2hu4XpxBs6qVem5e32y+8reNoAtMby\nQvHAp9BOQqf50u1yHC1Iash0CmgaAofnmA4vNRhwm1FmiT8eolpCmbcOrmPlmJjd\nV8PeQMRWDszje3QYPEHhT8W0l+Inz0gwB4ZC30zcDz3RDnXFCgHf04q7JNyFAMiJ\nd2fRjWU7tu4ufXdsNVai3nIFTjgNvGBZotpE0xFbU/ztXLj/nYfimDbc9fwpSiXI\nONrK1c5vAgMBAAECggEAGsEJgZpyO243j2AUYEK4i7Ai2jiXVkTUncn+5gZ6d8g/\ngTueqpZGBsc8p4r9HkkzneD11Kczfj2UhYcg4KUZZ2IqwR6KA4w9ozCbSEo23nUP\nwoQgPFre9ufB/QKanBo29d/Pf1QtRCmINJ1iE5y/KNPxVcEImp6zxaBbf9fWWFOi\nTJnSjlo60N6O1mMHivGMEOuHK0IZCuyGG+FQ28pYYulafl31VmKsYdW0U9I8BCw4\nwiaNKnAZUG3ulrtyJMEIIHutKdp+P1MNq5pFrbwFWOJ5Zr5TEPisrGNGFEncJfZ2\nrs0JGRu1YZJ50LQcYorXw/TAPpmGYXIy4kx+sL5aBQKBgQDx6EOWpv1p9R0P8nYa\nPVaOknoIJuPabyHc9Td9kdcQh0AmULPfmoDW9GPQqSOg0HThTtCFqFSm/qEHocyQ\nkVlJxSm4NZU4dQ2LPQXhVgbb6L2K1QqDfoS/hOeTsPpZPZGDFsLuUBDuFZF71QyM\nHOOZAwnn6LVYlQonY9F+X1OcBQKBgQDGZiMfuv/E18hVU8dvHVk8N3a9E5Ri3fv3\n09Te84P9Gp9CDlb6bhoo5zLR3tzj+gVDFIeQchr5uCuEth69KhPre06PE034yOWf\nMQuYvV1BtPjcNMOOU+7DPVWh6roKF/1MjM0spY/M4K11QGNqah4RAxk0NySmukue\nMS4Apch+4wKBgQC4dFY1JZfNl21Vn5eWYncBt4b9eEn9YQf9J63sPawzmi28CYVe\nVr0vKqKBlLbqBIla03IEuFn0C+xVmXYWNf5TVdd98r2ZkweEyD8XlzUbsdf1aITf\nxzUJpBnAcA40xdGSl2SDuuFt6VxJhCZRICYbokmHX9YHeX2Ik4BGUAG80QKBgCaX\nf4WQjmfvwVw3q7eFcfIwp7wnrtl8bKLMZb/ohmgZYZkryOd1u0jxkAUa4MTHwXZG\n7AfA6lZg6LYr5tbM9Ir9tU5HZwdZrLDGjYbsbtN1LGNJMDDjSrJXn+ybCA0mlXLq\ngI6KteoYWiVQnQX6FlcgzypE/7Ae1M60qkod9V4ZAoGBAK/FDfW3pJlLatBTnKsN\nMIhjjrKXMbJygzsaXVHzECoJgdcyIOuu2YDJhKkAlNUkpxFCgTwqWMuA2IVkGjce\njDczrEMDcxLcw8KWk4ADiadUjPg0DhkST+b83svRcffu9WKEKuSTc+T3suPUqtZg\nvT77Pry6YoeMi01rwzwOBmhl\n-----END PRIVATE KEY-----\n",
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
