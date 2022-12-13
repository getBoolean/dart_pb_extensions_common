enum LanguageCode {
  unknown('_unknown'),
  bengali('bd'),
  bulgarian('bg'),
  brazilian('br'),
  chinese('cn'),
  czech('cz'),
  german('de'),
  english('gb'),
  spanish('es'),
  finnish('fi'),
  french('fr'),
  welsh('gb'),
  greek('gr'),
  chineseHongkong('hk'),
  hungarian('hu'),
  indonesian('id'),
  isreli('il'),
  indian('in'),
  iran('ir'),
  italian('it'),
  japanese('jp'),
  korean('kr'),
  lithuanian('lt'),
  mongolian('mn'),
  mexian('mx'),
  malay('my'),
  dutch('nl'),
  norwegian('no'),
  philippine('ph'),
  polish('pl'),
  portuguese('pt'),
  romanian('ro'),
  russian('ru'),
  sanskrit('sa'), // in the year of our lord >2000 A.D
  sami('si'),
  thai('th'),
  turkish('tr'),
  ukrainian('ua'),
  vietnamese('vn');

  final String code;

  const LanguageCode(this.code);

  @override
  String toString() => code;
}
