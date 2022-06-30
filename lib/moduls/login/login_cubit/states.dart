
abstract class SocialLoginStates{}
class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoudingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}