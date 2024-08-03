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
      title: 'Mejoras en el loading',
      desc:
          'Ahora la seccion "live" se queda cargando hasta que recupera la tienda',
      date: '2024-07-29',
      isImportant: false,
      version: packageInfo.version,
    ),
    ResumePatch(
      title: 'Cambios en el login',
      desc:
          'Se cambio la manera en la que se muestra el login y validaciones cuando la app se pone en segundo plano',
      date: '2024-07-29',
      isImportant: false,
      isInactive: true,
      version: '2.0.0',
    ),
    ResumePatch(
      title: 'Se implemento login temporal',
      desc:
          'Se agrego inicio de sesion temporal para ver la tienda, aun se espera el nuevo servicio de riot',
      date: '2024-07-28',
      isImportant: false,
      isInactive: true,
      version: '1.1.2',
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
