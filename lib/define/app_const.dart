class AppConst {
  AppConst._();

  static const roomIdReg = r'^[0-9]+$';

  static const userNameMaxLength = 16;

  static const iconExtensionList = [
    'png',
    'PNG',
    'jpeg',
    'jpg',
    'JPEG',
    'JPG',
  ];

  static const defaultLifeChoiceList = [
    50,
    100,
    150,
    200,
    300,
    400,
    500,
  ];

  static const termsUrl = 'https://fripo-212b7.web.app/terms/';

  static const policyUrl = 'https://fripo-212b7.web.app/policy/';

  static const googleFormUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSchLo2ZGGn-uZSIZJnJnb0mpVvKqho4ixL3Z3jtcaIObgDdfA/viewform';

  static const reviewRequestText = """
クローズドβテストにご参加いただき、ありがとうございます。

リリースに向けて皆様のご意見を頂戴しアプリの改善を図るため、アンケートへのご協力をお願いいたします。""";
}
