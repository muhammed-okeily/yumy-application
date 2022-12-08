class Orders {
  String? documentId;
  int? totalePrice;
  String? address;
  String? phone;
  String? name;
  DateTime? dateTimeNow;
  Orders(
      {this.totalePrice, this.address, this.documentId, this.phone, this.name ,this.dateTimeNow});
}
