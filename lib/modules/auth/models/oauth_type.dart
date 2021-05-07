enum OAuthType { KAKAO, NAVER, GOOGLE }

class OAuthTypeValues {
  static const KAKAO_STRING_VALUE = "KAKAO";
  static const NAVER_STRING_VALUE = "NAVER";
  static const GOOGLE_STRING_VALUE = "GOOGLE";
}

extension OAuthTypeExtension on OAuthType {
  get value => _getValue();
  String _getValue() {
    switch (this) {
      case OAuthType.KAKAO:
        return OAuthTypeValues.KAKAO_STRING_VALUE;
      case OAuthType.NAVER:
        return OAuthTypeValues.NAVER_STRING_VALUE;
      case OAuthType.GOOGLE:
        return OAuthTypeValues.GOOGLE_STRING_VALUE;
      default:
        throw "Unsupported OAuthType $this";
    }
  }
}

class OAuthTypeParser {
  static OAuthType getByString(String oAuthType) {
    switch (oAuthType) {
      case OAuthTypeValues.KAKAO_STRING_VALUE:
        return OAuthType.KAKAO;
      case OAuthTypeValues.NAVER_STRING_VALUE:
        return OAuthType.NAVER;
      case OAuthTypeValues.GOOGLE_STRING_VALUE:
        return OAuthType.GOOGLE;
      default:
        throw "Unsupported OAuthType $oAuthType";
    }
  }
}
