import 'package:package_info_plus/package_info_plus.dart';

class ResumePatch {
  final String title;
  final String desc;
  final String date;
  final String version;
  final List<String> descriptions;

  ResumePatch({
    required this.title,
    required this.desc,
    required this.date,
    required this.version,
    this.descriptions = const [],
  });
}

Future<List<ResumePatch>> getNotesPatch() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final resumeList = <ResumePatch>[
    ResumePatch(
      title: 'Arreglo de rendimiento',
      desc: 'Se pintaba las pantallas muchas veces',
      date: _extractDate(DateTime.now().toString()),
      version: packageInfo.version,
    ),
  ];
  return resumeList;
}

String _extractDate(String dateTimeStr) {
  final parts = dateTimeStr.split(' ');

  return parts[0];
}
