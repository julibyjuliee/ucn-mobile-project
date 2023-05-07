class Person {
  final String nombre;
  final int edad;

  Person({required this.nombre, required this.edad});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'edad': edad,
    };
  }
}
