enum StateRequest {
  approved,
  executed,
  pending,
  denied
}

class Request {
  final String _id;
  final String _userName;
  final String _action;             // la define al sistema
  StateRequest _state;
  final String _message;
  final DateTime _date;             // fecha de envio no de creacion

  String? _responseMessage;
  DateTime? _responseDate;

  Request({
    required String userName,
    required String message,
    required String action,
    required DateTime date,
    required StateRequest state
  }) : _id = "f746886",
    _userName = userName,
    _message = message,
    _action = action,
    _date = date,
    _state = state;

  String get ID => _id;
  String get userName => _userName;
  String get action => _action;
  String? get sState {
    switch (_state) {
      case StateRequest.approved:
        return "Aprobada";
      case StateRequest.denied:
        return "Denegado";
      case StateRequest.executed:
        return "Ejecutado";
      case StateRequest.pending:
        return "Pendiente";
    }
  }
  StateRequest get state => _state;
  String get message => _message;
  DateTime get date => _date;

  String? get responseMessage => _responseMessage;
  DateTime? get responseDate => _responseDate;
}

final List<Request> requests = <Request>[
  Request(
    userName: "etoPok",
    message: "Necesito instalar una versión del motor Unity para desarrollar mi videojuego",
    action: "Instalación de motor Unity",
    date: DateTime(2025, 5, 14, 20, 30, 45, 0, 0),
    state: StateRequest.executed
  ),
  Request(
    userName: "Hemmi",
    message: "Necesito instalar Git para gestionar las versiones de mi proyecto",
    action: "Instalación de Git",
    date: DateTime(2025, 5, 14, 20, 30, 45, 0, 0),
    state: StateRequest.executed
  ),
  Request(
    userName: "Yetone",
    message: "Necesito este permiso para terminar de configurar el entorno de desarrollo",
    action: "Acceso a directorio",
    date: DateTime(2025, 5, 13, 20, 30, 45, 0, 0),
    state: StateRequest.approved
  ),
  Request(
    userName: "JuanDev",
    message: "Requiero acceso temporal a la configuración del firewall para probar la conexión de red de mi aplicación.",
    action: "Acceso a configuración de Firewall",
    date: DateTime(2025, 5, 12, 11, 45, 22),
    state: StateRequest.denied
  ),
  Request(
    userName: "Mijin",
    message: "Estoy intentando ejecutar pruebas automáticas pero necesito permisos para acceder al directorio del sistema.",
    action: "Permiso de lectura en carpeta protegida",
    date: DateTime(2025, 5, 11, 14, 10, 13),
    state: StateRequest.pending
  ),
  Request(
    userName: "devOpsLuis",
    message: "Instalación de herramientas necesarias para compilar proyectos en C++.",
    action: "Instalación de Visual Studio Build Tools",
    date: DateTime(2025, 5, 11, 18, 20, 45),
    state: StateRequest.approved
  ),
  Request(
    userName: "anaUX",
    message: "Quiero cambiar la zona horaria del sistema porque estoy viajando y afecta mis entregas.",
    action: "Cambio de configuración regional",
    date: DateTime(2025, 5, 10, 16, 00, 00),
    state: StateRequest.denied
  ),
  Request(
    userName: "alexDevOps",
    message: "Se requiere reiniciar el servidor de integración continua por tareas de mantenimiento.",
    action: "Reinicio de servicios críticos",
    date: DateTime(2025, 5, 9, 22, 00, 00),
    state: StateRequest.approved,
  ),
  Request(
    userName: "juanAdmin",
    message: "Quiero actualizar el nombre de dominio interno para reflejar la nueva estructura organizacional.",
    action: "Cambio de configuración de red",
    date: DateTime(2025, 5, 8, 17, 45, 00),
    state: StateRequest.denied,
  ),
  Request(
    userName: "marcelaQA",
    message: "Solicito acceso temporal a la base de datos de pruebas para validar los últimos cambios.",
    action: "Acceso a recursos restringidos",
    date: DateTime(2025, 5, 7, 14, 15, 00),
    state: StateRequest.pending,
  ),
  Request(
    userName: "devCarlos",
    message: "Necesito permisos de escritura en el directorio compartido para subir los archivos del proyecto.",
    action: "Modificación de permisos de archivo",
    date: DateTime(2025, 5, 6, 9, 30, 00),
    state: StateRequest.approved,
  ),
];