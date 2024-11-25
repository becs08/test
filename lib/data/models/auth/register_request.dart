class RegisterRequest{
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final String password;

  RegisterRequest({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.password
  });

  Map<String,dynamic> toJson(){
    return {
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'password': password
    };
  }

}