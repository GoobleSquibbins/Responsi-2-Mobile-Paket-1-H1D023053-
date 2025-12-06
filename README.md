Nama: Ananda Arsya Sabili

HIM: H1D023053

Shift Awal: H

Shift Baru: E

API: https://github.com/GoobleSquibbins/Responsi-2-Mobile-Paket-1-H1D02353---API

---

## API SPEC

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
