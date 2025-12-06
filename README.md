Nama: Ananda Arsya Sabili

HIM: H1D023053

Shift Awal: H

Shift Baru: E

API: https://github.com/GoobleSquibbins/Responsi-2-Mobile-Paket-1-H1D02353---API

---

### DEMO

<img src="2025-12-06 18-01-59.gif">

---

### PENJELASAN SINGKAT
Penjelasan Kode
**1. Login Page (login_page.dart)**

Mengelola autentikasi pengguna.

Mengambil email dan password dari TextEditingController.

Memanggil ApiService().login() untuk mendapatkan token.

Jika berhasil, navigasi ke ItemsListPage dengan membawa token.

**2. Side Menu (SideMenu.dart)**

Drawer menu untuk navigasi.

Terdapat menu List Item, Register, dan Logout.

Logout memanggil ApiService().logout() dan membersihkan riwayat navigasi jika berhasil.

**3. Items List Page (items_list_page.dart)**

Menampilkan daftar item menggunakan ListView.

Mengambil data dari backend via ApiService().fetchItems(token).

Tombol floating untuk menambah item (AddItemPage).

Setiap item memiliki tombol Edit dan Delete:

Edit → EditItemPage.

Delete → ApiService().deleteItem() kemudian refresh list.

**4. Add Item Page (add_item_page.dart)**

Form untuk menambahkan item baru: nama, harga, jumlah, tanggal_masuk.

Menggunakan TextField dan date picker untuk tanggal.

Submit → memanggil ApiService().createItem(token, item).

**5. Edit Item Page (edit_item_page.dart)**

Mirip Add Item Page, tetapi field sudah terisi data item.

Submit → memanggil ApiService().updateItem(token, id, item).

**6. API Service (api_services.dart)**

Kelas pusat untuk semua request ke backend.

Fungsi utama:

login() → autentikasi user.

register() → daftar user baru.

logout() → hapus token.

fetchItems() → ambil semua item.

createItem() → tambah item.

updateItem() → ubah item.

deleteItem() → hapus item.

Semua request memakai Bearer token.

Mengatur konversi JSON dan pengecekan response.

**7. Item Model (items.dart)**

Representasi objek item.

Field: id, nama, harga, jumlah, tanggal_masuk.

Ada fromJson() dan toJson() untuk konversi JSON.

**8. Navigasi**

Navigator.push() / Navigator.pop() untuk berpindah halaman.

pushNamedAndRemoveUntil() dipakai saat logout untuk hapus riwayat navigasi.

---

### API SPEC

---

### A. Registrasi

| Endpoint    | Method | Headers                        | Body                                                                                               |
| ----------- | ------ | ------------------------------ | -------------------------------------------------------------------------------------------------- |
| `/register` | POST   | Content-Type: application/json | `{ "name": "string", "email": "string", "password": "string", "password_confirmation": "string" }` |

**Response**

| Code | Status | Data                                                                                        |
| ---- | ------ | ------------------------------------------------------------------------------------------- |
| 201  | true   | `{ "token": "string", "user": { "id": 1, "name": "John Doe", "email": "user@email.com" } }` |
| 400  | false  | `{ "success": false, "message": "Error message" }`                                          |

---

### B. Login

| Endpoint | Method | Headers                        | Body                                          |
| -------- | ------ | ------------------------------ | --------------------------------------------- |
| `/login` | POST   | Content-Type: application/json | `{ "email": "string", "password": "string" }` |

**Response**

| Code | Status | Data                                                                                        |
| ---- | ------ | ------------------------------------------------------------------------------------------- |
| 200  | true   | `{ "token": "string", "user": { "id": 1, "name": "John Doe", "email": "user@email.com" } }` |
| 401  | false  | `{ "error": "Invalid credentials", "status": 401 }`                                         |

---

### C. Logout

| Endpoint  | Method | Headers                     | Body |
| --------- | ------ | --------------------------- | ---- |
| `/logout` | POST   | Authorization: Bearer TOKEN | —    |

**Response**

| Code | Status | Data                               |
| ---- | ------ | ---------------------------------- |
| 200  | true   | `{ "message": "Logged out" }`      |
| 401  | false  | `{ "message": "Unauthenticated" }` |

---

### D. Items (Produk)

#### 1. List Items

| Endpoint | Method | Headers                     | Body |
| -------- | ------ | --------------------------- | ---- |
| `/items` | GET    | Authorization: Bearer TOKEN | —    |

**Response**

| Code | Status | Data                                                                                                 |
| ---- | ------ | ---------------------------------------------------------------------------------------------------- |
| 200  | true   | `[ { "id": 1, "nama": "Item A", "harga": 10000, "jumlah": 5, "tanggal_masuk": "2025-12-06" }, ... ]` |

---

#### 2. Add Item

| Endpoint | Method | Headers                                                     | Body                                                                               |
| -------- | ------ | ----------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `/items` | POST   | Authorization: Bearer TOKEN, Content-Type: application/json | `{ "nama": "string", "harga": 10000, "jumlah": 5, "tanggal_masuk": "YYYY-MM-DD" }` |

**Response**

| Code | Status | Data                                                                                        |
| ---- | ------ | ------------------------------------------------------------------------------------------- |
| 201  | true   | `{ "id": 1, "nama": "Item A", "harga": 10000, "jumlah": 5, "tanggal_masuk": "2025-12-06" }` |
| 400  | false  | `{ "message": "Error message" }`                                                            |

---

#### 3. Update Item

| Endpoint      | Method | Headers                                                     | Body                                                                               |
| ------------- | ------ | ----------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `/items/{id}` | PUT    | Authorization: Bearer TOKEN, Content-Type: application/json | `{ "nama": "string", "harga": 10000, "jumlah": 5, "tanggal_masuk": "YYYY-MM-DD" }` |

**Response**

| Code | Status | Data                                                                                        |
| ---- | ------ | ------------------------------------------------------------------------------------------- |
| 200  | true   | `{ "id": 1, "nama": "Item A", "harga": 10000, "jumlah": 5, "tanggal_masuk": "2025-12-06" }` |
| 400  | false  | `{ "message": "Error message" }`                                                            |
| 404  | false  | `{ "message": "Item not found" }`                                                           |

---

#### 4. Delete Item

| Endpoint      | Method | Headers                     | Body |
| ------------- | ------ | --------------------------- | ---- |
| `/items/{id}` | DELETE | Authorization: Bearer TOKEN | —    |

**Response**

| Code | Status | Data                              |
| ---- | ------ | --------------------------------- |
| 200  | true   | `{ "message": "Item deleted" }`   |
| 404  | false  | `{ "message": "Item not found" }` |

---
