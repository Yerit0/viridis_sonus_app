import 'dart:convert';

class Usuario {
    Usuario({
        required this.userName,
        required this.name,
        required this.surname,
        required this.apellidoMaterno,
        required this.emailAddress,
        required this.isActive,
        required this.fullName,
        this.lastLoginTime,
        required this.creationTime,
        required this.roles,
        required this.id,
    });

    String userName;
    String name;
    String surname;
    String apellidoMaterno;
    String emailAddress;
    bool isActive;
    String fullName;
    dynamic? lastLoginTime;
    DateTime creationTime;
    List<String> roles;
    int id;

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        userName: json["userName"],
        name: json["name"],
        surname: json["surname"],
        apellidoMaterno: json["apellidoMaterno"],
        emailAddress: json["emailAddress"],
        isActive: json["isActive"],
        fullName: json["fullName"],
        lastLoginTime: json["lastLoginTime"],
        creationTime: DateTime.parse(json["creationTime"]),
        roles: List<String>.from(json["roles"].map((x) => x)),
        id: json["id"],
    );

}
