import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String firebaseMessagingScope =
      'https://www.googleapis.com/auth/firebase.messaging';

  /// Retrieves the access token for Firebase Messaging.
  ///
  /// This function uses the service account credentials to authenticate with
  /// the Google API and obtain an access token for Firebase Messaging. The
  /// obtained access token is then returned.
  ///
  /// Returns:
  ///   A `Future` that resolves to a `String` representing the access token.
  ///
  /// Throws:
  ///   - `ClientException`: If there was an error while authenticating with
  ///     the Google API.
  ///   - `SocketException`: If there was a network-related error while
  ///     retrieving the access token.
  ///   - `FormatException`: If the response from the Google API was not in the
  ///     expected format.

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "pushnotification-23-may",
          "private_key_id": "04ddae22f2ab84187d2b8f789fa342d5404757ac",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC2fkJVoNcYzwIn\nCghrw48gG7avDxoKDHSGhvyq+aWTh9hIHKHVlQd7udWjoNZOLE2yejdXSN3ufFqZ\npfDtu6VCJOFkV4l2dYrxXJt/nhisa2If7RchGN9A5F84g4AHqbjk4QF9R+tnENeP\nElfNf7d18nanwDgzhWWSQ4/0h6g86MGq5qGOUVdrVSS0BCT6xr7RfmwkFI6tg0f9\nXbWP69K7lkufvWdGdnA6FtZwXz0jA1e20H9wN1OCjrkjIShpPCNpfp+Mb4SPi20s\nC+YribnC98wtWxIzfliwXg04pXMR8RR4Y9lSJlVSY2d7Wuk/93O0VHvCH8xTG/3P\nN0cZcTF/AgMBAAECggEAK689odHGq6GiGkZEjcdaU41OxckPqqggnLNjeGoaQJ6c\nH2b7Nm1eRTfO9ERkCIKCdt7asII43gXWikE20zG/9X1ult59gWXRxMUuU/Y8Ycmy\ny4Gtr7aMerQwNw8DbtIp+GAEQ0EcEKfvccgqTH7uI8XOsYlJ6stb7Q9PPnHay/lj\nyG94jV8h5NQP5H84iqPb+6k1TmT3ZJmOQBvx9PWfgfx4sUIQFkJOodUBQz69dEkk\n5IvF+/T89Qyz4eO76gfbWVFmzUtzjuAHeJIO48Ks2R9tNNS32SIblsQ3PL8HQDDY\nJWCeEGWuKADuoCWfZi3TWIdOrhl/H7t9V+swixiPwQKBgQDrQy7f3mpf2slutC1R\nmELtZFfuR97IKnNCAOKIsp2mUG3l853Y3CdcRzW0IK5kS8Egq7u65IBkRz6VqPET\nXIN6x+AOcz+YQdyca0WIBhS+WVy+0W23VZxJkRPL1d5TWNFXOAkk3VY7C7hrNidZ\nc+ZQ6bA4oifpVkHB96ygIw2kzQKBgQDGlE+yErr8MxvBm9sNL6ktNTEuO9zo81D9\nFPznZkEtNU7dSgndIQiiTnaO69LHCYqmC3Y+etNg51hZBiOV70l6AeJy1URGNiBJ\nXg6y5/HGFoJGmWH8hG1nni8BAtrm0WdnQDYYkXjKjOqVYfuQph+aAbBJCq+9gETv\n8HeVwicPewKBgQC2tGYi1cgmyPLGVocbZvQTCGqBUq9hJBZ+m9FR9+UW1D+E5b0g\nPVkUAPlj+j11Bp/lj3krm2ladznTYHBYaPBy2ebXUgmBZSS/FU/aY16YtS2hw2NB\njerh9xk4o88VS1TIN2xihMIC+Qcvu86zWZ70F4gTc1sriyFmUcJuWsqtwQKBgC95\nfaQg/jsVLOmYjUIVxuhb8yoOfb3jjdUzk1LvC133hKc68CjBoQLMp2N71aRoD5Gq\n49YEH0zngiOmaBOMZZCZqr2xZuUyQ33G0tTKxu6IqxSdzuND9bP0CWDAgfz0yzfQ\nDh7JiItELUERb8chMCTtimur9l/jrpd+cdiH1jbJAoGBAI9pNrgvXSoc0Vlnug5l\nprKkCk/wrzaBn5wEjEmNPUZ87pcXntkVoSRVNRJkX5ms9IIuki+I+8TNm2SlXmUh\naX7c14EeQf/aIYWa52etBgwEXNVKdUtWW0JjZXjac3keqmmJnXwGBhKjKdmrGBkj\nmJGZ1GVHboezqfpbH0HSTKMP\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-pby1w@pushnotification-23-may.iam.gserviceaccount.com",
          "client_id": "102602078131839345353",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-pby1w%40pushnotification-23-may.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);
    final String accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
