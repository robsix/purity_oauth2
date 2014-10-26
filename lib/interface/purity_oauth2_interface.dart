/**
 * Author:  Daniel Robinson http://github.com/0xor1
 */

library purity.oauth2.interface;

@MirrorsUsed(targets: const[
  IOAuth2LoginUrlRedirection,
  IOAuth2LoginUserDetails,
  IOauth2ResourceResponse,
  ILogin
  ], override: '*')
import 'dart:mirrors';
import 'package:purity/purity.dart';

bool _purityOAuth2TranTypeRegistered = false;
final Registrar  registerPurityOAuth2TranTypes = generateRegistrar(
    'purity.oauth2.tran', 'pot', [
    new TranRegistration.subtype(OAuth2LoginUrlRedirection, () => new OAuth2LoginUrlRedirection()),
    new TranRegistration.subtype(OAuth2LoginAccessGranted, () => new OAuth2LoginAccessGranted()),
    new TranRegistration.subtype(OAuth2LoginInProgress, () => new OAuth2LoginInProgress()),
    new TranRegistration.subtype(OAuth2LoginNotComplete, () => new OAuth2LoginNotComplete()),
    new TranRegistration.subtype(OAuth2LoginTimeOut, () => new OAuth2LoginTimeOut()),
    new TranRegistration.subtype(OAuth2LoginAccessDenied, () => new OAuth2LoginAccessDenied()),
    new TranRegistration.subtype(OAuth2LoginUnkownError, () => new OAuth2LoginUnkownError()),
    new TranRegistration.subtype(OAuth2LoginClientClosed, () => new OAuth2LoginClientClosed()),
    new TranRegistration.subtype(OAuth2LoginUserDetails, () => new OAuth2LoginUserDetails()),
    new TranRegistration.subtype(Oauth2ResourceResponse, () => new Oauth2ResourceResponse())
  ]);

abstract class ILogin implements Source{
  /// start the oauth2 login process.
  void login();
  /// set the time in seconds from when the login process starts to the point when it times out.
  void setLoginTimeout(int seconds);
  /// request a resource, this will fail if the login has not already successfully completed.
  void requestResource(String resource, {Map<String, String> headers});
  /// request the logged in users details.
  void requestUserDetails();
  /// closes the client connection
  void close();
}

class OAuth2LoginUrlRedirection extends Transmittable implements IOAuth2LoginUrlRedirection{}
abstract class IOAuth2LoginUrlRedirection{
  String url;
}

class OAuth2LoginAccessGranted extends Transmittable{}

class OAuth2LoginInProgress extends Transmittable{}

class OAuth2LoginNotComplete extends Transmittable{}

class OAuth2LoginTimeOut extends Transmittable{}

class OAuth2LoginAccessDenied extends Transmittable{}

class OAuth2LoginUnkownError extends Transmittable{}

class OAuth2LoginClientClosed extends Transmittable{}

class OAuth2LoginUserDetails extends Transmittable implements IOAuth2LoginUserDetails{}
abstract class IOAuth2LoginUserDetails{
  String firstName;
  String lastName;
  String id;
  String email;
  String displayName;
  String imageUrl;
}

class Oauth2ResourceResponse extends Transmittable implements IOauth2ResourceResponse{}
abstract class IOauth2ResourceResponse{
  String response;
}