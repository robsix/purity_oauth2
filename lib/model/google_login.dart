/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

part of purity.oauth2.model;

class GoogleLogin extends Login{
  static Uri _AUTH_URL = new Uri.https('accounts.google.com', '/o/oauth2/auth');
  static Uri _TOKEN_URL = new Uri.https('accounts.google.com', '/o/oauth2/token');

  GoogleLogin(
    String redirectUrl,
    String clientId,
    String secret,
    List<String> scopes)
  :super(
    _AUTH_URL,
    _TOKEN_URL,
    Uri.parse(redirectUrl),
    clientId,
    secret,
    scopes);

  void requestUserDetails(){
    if(_client == null) return;
    _client.read('https://www.googleapis.com/userinfo/v2/me')
    .then((String response){
      var data = JSON.decode(response);
      emit(
        new OAuth2LoginUserDetails()
        ..firstName = data['given_name']
        ..lastName = data['family_name']
        ..id = data['id']
        ..email = data['email']
        ..displayName = data['name']
        ..imageUrl = data['picture']);
      });
  }
}