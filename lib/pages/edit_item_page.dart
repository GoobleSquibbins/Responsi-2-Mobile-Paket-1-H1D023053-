import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/items.dart';

class EditItemPage extends StatefulWidget {
  final String token;
  final Items item;

  const EditItemPage({Key? key, required this.token, required this.item})
    : super(key: key);

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController nameCtrl;
  late TextEditingController hargaCtrl;
  late TextEditingController jumlahCtrl;
  late TextEditingController tanggalCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.item.nama);
    hargaCtrl = TextEditingController(text: widget.item.harga.toString());
    jumlahCtrl = TextEditingController(text: widget.item.jumlah.toString());
    tanggalCtrl = TextEditingController(text: widget.item.tanggalMasuk);
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final initialDate = DateTime.tryParse(tanggalCtrl.text) ?? now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        tanggalCtrl.text =
            "${picked.year.toString().padLeft(4, '0')}-"
            "${picked.month.toString().padLeft(2, '0')}-"
            "${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item Arsyamart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Nama Item"),
            ),
            TextField(
              controller: hargaCtrl,
              decoration: const InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: jumlahCtrl,
              decoration: const InputDecoration(labelText: "Jumlah"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: tanggalCtrl,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Masuk",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: pickDate,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (tanggalCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pilih tanggal masuk terlebih dahulu"),
                    ),
                  );
                  return;
                }

                final updatedItem = Items(
                  id: widget.item.id,
                  nama: nameCtrl.text,
                  harga: int.parse(hargaCtrl.text),
                  jumlah: int.parse(jumlahCtrl.text),
                  tanggalMasuk: tanggalCtrl.text,
                );

                await ApiService().updateItem(
                  widget.token,
                  widget.item.id,
                  updatedItem,
                );

                Navigator.pop(context, true);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
