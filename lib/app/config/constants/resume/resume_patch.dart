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
      title: 'Cambios visuales',
      desc: 'Se mejoro la forma en la que se muestran los packs de la tienda, correccion de errores',
      date: '2024-10-26',
      isImportant: false,
      version: '${packageInfo.version}+1',
    ),
    ResumePatch(
      title: 'Implementacion del mercado nocturno',
      desc: 'Se agrego el mercado nocturno y se implementaron algunas mejoras',
      date: '2024-08-16',
      isImportant: false,
      version: '2.0.0+3',
    ),
    ResumePatch(
      title: 'Mejoras graficas',
      desc:
          'Se cambio la manera en ver los idiomas, se modifico los items de los packs, se arreglo y implemento carga en el login',
      date: '2024-08-08',
      isImportant: false,
      version: '2.0.0+2',
    ),
    ResumePatch(
      title: 'Mejoras en el texto',
      desc: 'Se implemento el cambio de idioma',
      date: '2024-08-08',
      isImportant: false,
      isInactive: true,
      version: '2.0.0+1',
    ),
    ResumePatch(
      title: 'Mejoras en el loading',
      desc:
          'Ahora la seccion "live" se queda cargando hasta que recupera la tienda',
      date: '2024-07-29',
      isImportant: false,
      isInactive: true,
      version: '2.0.0',
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
