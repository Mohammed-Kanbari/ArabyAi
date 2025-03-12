class User {
  final String email;
  final String password; // Plain text for now; hash with Firebase later
  final String username;

  User({required this.email, required this.password, required this.username});
}