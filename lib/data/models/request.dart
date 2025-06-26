enum StateRequest {
  executed("Ejecutado"),
  approved("Aprobado"),
  pending("Pendiente"),
  denied("Denegado");
  final String legibleName;
  const StateRequest(this.legibleName);
  static StateRequest? stringToStateRequest(String state) {
    switch (state) {
      case "Ejecutado": return StateRequest.executed;
      case "Aprobado": return StateRequest.approved;
      case "Pendiente": return StateRequest.pending;
      case "Denegado": return StateRequest.denied;
    }
    return null;
  }
}

class Request {
  final int _id;
  final String _userName;
  final String _action;             // la define al sistema
  StateRequest _state;
  final String _message;
  final DateTime _date;             // fecha de envio no de creacion

  final String? _responseMessage;
  final DateTime? _responseDate;

  Request({
    required String userName,
    required String message,
    required String action,
    required DateTime date,
    required StateRequest state,
    int id = 0,
    String? responseMessage,
    DateTime? responseDate
  }) : _userName = userName,
    _message = message,
    _action = action,
    _date = date,
    _state = state,
    _id = id,
    _responseMessage = responseMessage,
    _responseDate = responseDate;

  int get id => _id;
  String get userName => _userName;
  String get action => _action;
  StateRequest get state => _state;
  String get message => _message;
  DateTime get date => _date;

  String? get responseMessage => _responseMessage;
  DateTime? get responseDate => _responseDate;

  Map<String, Object?> toMap() {
    return {"userName": _userName, "message": _message, "action": _action,
      "date": _date.toIso8601String(), "state": _state.legibleName, "responseMessage": _responseMessage ?? "",
      "responseDate": _responseDate?.toIso8601String() ?? ""};
  }

  factory Request.fromMap(Map<String, Object?> map) {
    parseResponseDate(String? rawDate) {
      if (rawDate == null || rawDate.trim().isEmpty) {
        return null;
      }

      try {
        return DateTime.parse(rawDate);
      } catch (e) {
        return null;
      }
    }

    return Request(
      id: map["id"] as int,
      userName: map["userName"] as String,
      message: map["message"] as String,
      action: map["action"] as String,
      date: DateTime.parse(map["date"] as String),
      state: StateRequest.stringToStateRequest(map["state"] as String) ?? StateRequest.pending,
      responseMessage: map["responseMessage"] as String,
      responseDate: parseResponseDate(map["responseDate"] as String?)
    );
  }

  Request copyWith({
    String? userName,
    String? message,
    String? action,
    DateTime? date,
    StateRequest? state,
    String? responseMessage,
    DateTime? responseDate
  }) {
    return Request(
      id: _id,
      userName: userName ?? _userName,
      message: message ?? _message,
      action: action ?? _action,
      date: date ?? _date,
      state: state ?? _state,
      responseMessage: responseMessage ?? _responseMessage,
      responseDate: responseDate ?? _responseDate
    );
  }
}

final List<Request> requests = <Request>[
  Request(
    userName: "etoPok",
    message: "Necesito instalar una versión del motor Unity para desarrollar mi videojuego",
    action: "Instalación de motor Unity",
    date: DateTime(2025, 5, 14, 20, 30, 45),
    state: StateRequest.executed,
    responseMessage: "Instalación autorizada. Asegúrate de seguir las políticas de uso del software.",
    responseDate: DateTime(2025, 5, 14, 20, 45, 00),
  ),
  Request(
    userName: "Hemmi",
    message: "Necesito instalar Git para gestionar las versiones de mi proyecto",
    action: "Instalación de Git",
    date: DateTime(2025, 5, 14, 20, 30, 45),
    state: StateRequest.executed,
    responseMessage: "Git ha sido instalado correctamente. Recuerda configurar tu identidad de usuario.",
    responseDate: DateTime(2025, 5, 14, 20, 40, 00),
  ),
  Request(
    userName: "Yetone",
    message: "Necesito este permiso para terminar de configurar el entorno de desarrollo",
    action: "Acceso a directorio",
    date: DateTime(2025, 5, 13, 20, 30, 45),
    state: StateRequest.approved,
    responseMessage: "Acceso otorgado temporalmente. Asegúrate de cerrar sesión al finalizar.",
    responseDate: DateTime(2025, 5, 13, 21, 00, 00),
  ),
  Request(
    userName: "JuanDev",
    message: "Requiero acceso temporal a la configuración del firewall para probar la conexión de red de mi aplicación.",
    action: "Acceso a configuración de Firewall",
    date: DateTime(2025, 5, 12, 11, 45, 22),
    state: StateRequest.denied,
    responseMessage: "No es posible otorgar acceso directo al firewall. Coordina con el equipo de redes.",
    responseDate: DateTime(2025, 5, 12, 12, 00, 00),
  ),
  Request(
    userName: "Mijin",
    message: "Estoy intentando ejecutar pruebas automáticas pero necesito permisos para acceder al directorio del sistema.",
    action: "Permiso de lectura en carpeta protegida",
    date: DateTime(2025, 5, 11, 14, 10, 13),
    state: StateRequest.pending,
    responseMessage: "Tu solicitud está siendo revisada por el equipo de seguridad.",
    responseDate: DateTime(2025, 5, 11, 14, 25, 00),
  ),
  Request(
    userName: "devOpsLuis",
    message: "Instalación de herramientas necesarias para compilar proyectos en C++.",
    action: "Instalación de Visual Studio Build Tools",
    date: DateTime(2025, 5, 11, 18, 20, 45),
    state: StateRequest.approved,
    responseMessage: "Instalación aprobada. No olvides verificar las dependencias necesarias para tu proyecto.",
    responseDate: DateTime(2025, 5, 11, 18, 45, 00),
  ),
  Request(
    userName: "anaUX",
    message: "Quiero cambiar la zona horaria del sistema porque estoy viajando y afecta mis entregas.",
    action: "Cambio de configuración regional",
    date: DateTime(2025, 5, 10, 16, 00, 00),
    state: StateRequest.denied,
    responseMessage: "La zona horaria del sistema debe permanecer estandarizada. Considera usar herramientas de gestión de tiempo.",
    responseDate: DateTime(2025, 5, 10, 16, 15, 00),
  ),
  Request(
    userName: "alexDevOps",
    message: "Se requiere reiniciar el servidor de integración continua por tareas de mantenimiento.",
    action: "Reinicio de servicios críticos",
    date: DateTime(2025, 5, 9, 22, 00, 00),
    state: StateRequest.approved,
    responseMessage: "Reinicio programado aprobado. Informa al equipo para evitar interrupciones.",
    responseDate: DateTime(2025, 5, 9, 22, 10, 00),
  ),
  Request(
    userName: "juanAdmin",
    message: "Quiero actualizar el nombre de dominio interno para reflejar la nueva estructura organizacional.",
    action: "Cambio de configuración de red",
    date: DateTime(2025, 5, 8, 17, 45, 00),
    state: StateRequest.denied,
    responseMessage: "El cambio de dominio requiere planificación previa. Por favor coordina con infraestructura.",
    responseDate: DateTime(2025, 5, 8, 18, 00, 00),
  ),
  Request(
    userName: "marcelaQA",
    message: "Solicito acceso temporal a la base de datos de pruebas para validar los últimos cambios.",
    action: "Acceso a recursos restringidos",
    date: DateTime(2025, 5, 7, 14, 15, 00),
    state: StateRequest.pending,
    responseMessage: "Estamos evaluando tu solicitud. Se te notificará en cuanto se tome una decisión.",
    responseDate: DateTime(2025, 5, 7, 14, 30, 00),
  ),
  Request(
    userName: "devCarlos",
    message: "Necesito permisos de escritura en el directorio compartido para subir los archivos del proyecto.",
    action: "Modificación de permisos de archivo",
    date: DateTime(2025, 5, 6, 9, 30, 00),
    state: StateRequest.approved,
    responseMessage: "Permisos de escritura concedidos. Recuerda mantener una estructura organizada en el directorio.",
    responseDate: DateTime(2025, 5, 6, 9, 45, 00),
  ),
];