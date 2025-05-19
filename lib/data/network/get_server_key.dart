
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
          "private_key_id": "bb9f3d945d9d3b014c9b54a0344e7b132d90dc4d",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCuHsln6ig3a/xE\nKgntXc5D4PwCYHAk+qR/kh65VotdkyyfKFRB+55DReZ+MBYXl7gcF/Nyr7IgVNXS\neAoxp2IVQHA1EHMhcIncZ6Vm6+qSL0zZGKGZZNpbw4bYcNWYOqkrt3z2qbc87fmK\na6RtcA89P2n2LjRTEsmE4MyCDfb7O9ERrnQ6tPb7qjnOrBTOU37VJ9/gY8JRZwO9\nPj7H97C3KpU/I2pbAOJ9Saf0DFb4mvODybMlmF4HWc1r6+ZY8q3X3OlbSv69McjJ\ntBNV3ajVkeHgZ7HnW65S92/leCQ4PGSUzX64vwJg4NK+AF52acuhdWzFpaLpfOjj\nF+x80KRBAgMBAAECggEAFIo3MhXyRo9rg9L9ts2RDnrU36bms8YJb68aBr0J1bEN\n23yTa/E1uzPcu9gKUyAnrNC6fDXzqlK3ootckHzxWhZu5iOZoUE4UhK79UcxNat0\nwktgjMrT421OU+wDlmCdIjYT/LkKj5p3DHgkPnCwq4X2hv7uVzppIU6vcUwabYpw\nEIJQBOOb5ahR9EvK/nbDHqABmT9iwr0GW+/0cODtEEtdmTSUvZEnk1V5xC/acMsi\nKcISWTmuOVD/SEAx+CXFfAGkvmpgl7WlEAk0PCtEVRgureXdrbN2fM41vFVkQNNF\n2pVIYNnVtOe6LNwTv2+hUE7zc+PhvT9KrO3C/hj3DQKBgQDTYtoYGzxhPlmTcsQw\nrLipMRo6Z0Nla5t2Rm0j1tNDf4aZ8mq6kf3VGOK4f2txz1m6Yl1S809NNQJAyhkh\nznktUiQBbqbHtb5l3NxHrEuHv2cMFaQVYwkF69/bn7mXAbbnWYtlL9q9PuTvtJ2V\nc3cgOkBviTJ2FXhubd9rxZzktwKBgQDS3nef7r2IwA5nF4jx/06v+mA5UPXYTqwo\nZzXB8ETprveYvDVcTSNVTGSlsKSEUOfZ91QRJRJ62dn2nrpbGKwcj2uYJvNBp9go\nfZKtyB4ut6T/gyegxQ4S2oChVZF/drYC0Nw2AgN6QVxxZ69B01F7SpaVGYEP2YNn\nm+p0/4X2xwKBgQC1pcOeZYEsW0TkZQHchgAlPBG60FPlCmRMbdaJrqha33JORjea\n3auPfFQPkUdGRJVpie+CQZ0KzpuCC2kvWNteq7BPHsPo5++WXwVX/eHl4/9sLgiT\nbEgrs3bppsb30bxX7+XObSH979cReVbVP6TFp+kJL4+SU37q/jW4yda53wKBgHST\nRqDlNGUQgCXgLfZTRaYmDeJB7tfZjnV7sY15Di/+aaVHj1xqzLjQVef/wsPfkn2+\nrPwZeaDvJP+herb36daUN1BTYDIQ34BrA5cNRhpfrlkPoe3QYtprb6dBjgFgmHjw\nDH3TGScSUU/kmVATyj0V3C+rfN1NS8cQvEpYJTBrAoGBAJZmBcslhR2Ys7s0sS9t\nlU0yDmMncAVG5mUn5pVpX9UghQCcVmHj3OtADBlTuHftnq08Sz2yhfYOmUFvGcXJ\nCk1GuUr8oLQojqDqBVO0x3roM7E8Cs440HKtslYrWbILzqQrCN5Fz+IztNrYe4cV\nJ4vpk59rSCt8Bk4bfyR+exk7\n-----END PRIVATE KEY-----\n",
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
