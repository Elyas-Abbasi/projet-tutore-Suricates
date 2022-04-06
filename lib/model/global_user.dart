class GlobalUser {
  late String uid;
  late String pseudo;

  GlobalUser(
    this.uid,
    this.pseudo,
  );

  GlobalUser.id(String id) {
    uid = id;
  }
}
