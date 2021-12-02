class User {
  late String uid;
  late String email;
  late bool isAdmin;

  User.blank() {
    uid = '';
    email = '';
    isAdmin = false;
  }

  User(this.uid, this.email, this.isAdmin);
}
