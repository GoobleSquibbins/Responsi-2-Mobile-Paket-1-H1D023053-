import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/items.dart';
import '../SideMenu.dart';
import 'add_item_page.dart';
import 'edit_item_page.dart';

class ItemsListPage extends StatefulWidget {
  final String token;

  const ItemsListPage({required this.token, Key? key}) : super(key: key);

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  late Future<List<Items>> itemsFuture;

  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  void refreshItems() {
    setState(() {
      itemsFuture = ApiService().fetchItems(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item List Arsyamart")),
      drawer: SideMenu(token: widget.token),

      // ADD ITEM BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddItemPage(token: widget.token)),
          );

          if (result == true) refreshItems();
        },
        child: Icon(Icons.add),
      ),

      body: FutureBuilder<List<Items>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final items = snapshot.data ?? [];

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(item.nama),
                subtitle: Text(
                  "Harga: ${item.harga} | Jumlah: ${item.jumlah} | Tanggal Masuk: ${item.tanggalMasuk}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // EDIT BUTTON
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditItemPage(token: widget.token, item: item),
                          ),
                        );

                        if (result == true) refreshItems();
                      },
                    ),

                    // DELETE BUTTON
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await ApiService().deleteItem(widget.token, item.id);
                        refreshItems();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
