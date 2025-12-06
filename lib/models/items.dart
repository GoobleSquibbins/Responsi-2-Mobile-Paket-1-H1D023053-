// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

List<Items> itemsFromJson(String str) =>
    List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
  int id;
  String nama;
  int harga;
  int jumlah;
  String tanggalMasuk;
  dynamic createdAt;
  dynamic updatedAt;

  Items({
    required this.id,
    required this.nama,
    required this.harga,
    required this.jumlah,
    required this.tanggalMasuk,
    this.createdAt,
    this.updatedAt,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    nama: json["nama"],
    harga: json["harga"],
    jumlah: json["jumlah"],
    tanggalMasuk: json['tanggal_masuk'],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "harga": harga,
    "jumlah": jumlah,
    'tanggal_masuk': tanggalMasuk,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
