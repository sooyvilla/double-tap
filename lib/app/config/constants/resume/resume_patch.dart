import 'package:package_info_plus/package_info_plus.dart';

class ResumePatch {
  final String title;
  final String desc;
  final String date;
  final String version;
  final bool isImportant;
  final bool isInactive;
  final List<String> descriptions;

  ResumePatch({
    required this.title,
    required this.desc,
    required this.date,
    required this.version,
    required this.isImportant,
    this.isInactive = false,
    this.descriptions = const [],
  });
}

Future<List<ResumePatch>> getNotesPatch() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final resumeList = <ResumePatch>[
    ResumePatch(
      title: 'Se implemento login temporal',
      desc:
          'Se agrego inicio de sesion temporal para ver la tienda, aun se espera el nuevo servicio de riot',
      date: '2024-07-28',
      isImportant: true,
      version: packageInfo.version,
    ),
    ResumePatch(
      title: 'Arreglo de rendimiento',
      desc: 'Se pintaba las pantallas muchas veces',
      date: '2024-07-25',
      isImportant: false,
      isInactive: true,
      version: '1.1.1',
    ),
    ResumePatch(
      title: 'Arreglo de errores',
      desc: 'Se quedaban cargando los servicios',
      date: '2024-07-20',
      isImportant: false,
      isInactive: true,
      version: '1.1.0',
    ),
  ];
  return resumeList;
}
