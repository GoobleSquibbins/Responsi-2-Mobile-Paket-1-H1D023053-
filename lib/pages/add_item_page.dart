import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/items.dart';

class AddItemPage extends StatefulWidget {
  final String token;

  const AddItemPage({Key? key, required this.token}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController hargaCtrl = TextEditingController();
  final TextEditingController jumlahCtrl = TextEditingController();
  final TextEditingController tanggalCtrl = TextEditingController();

  // Date picker function
  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        // Convert DateTime to yyyy-mm-dd string for the DB
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
      appBar: AppBar(title: const Text("Tambah Item Arsyamart")),
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

                final item = Items(
                  id: 0,
                  nama: nameCtrl.text,
                  harga: int.parse(hargaCtrl.text),
                  jumlah: int.parse(jumlahCtrl.text),
                  tanggalMasuk: tanggalCtrl.text,
                );

                await ApiService().createItem(widget.token, item);

                Navigator.pop(context, true);
              },
              child: const Text("Tambah"),
            ),
          ],
        ),
      ),
    );
  }
}
