### Tugas 7

**1. Jelaskan bagaimana cara kerja widget tree pada Flutter dan bagaimana hubungan antara parent dan child dalam struktur tersebut.**

Widget tree merupakan struktur hierarkis yang menggambarkan susunan widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai child sehingga membentuk hubungan parent dan child.

Parent bertanggung jawab mengatur bagaimana child ditampilkan, misalnya melalui ukuran, posisi, alignment, dan layout. Satu parent dapat memiliki satu atau beberapa child, bergantung pada jenis widget yang digunakan.

Pada aplikasi MyPortfolio Mobile, Scaffold menjadi salah satu parent utama yang memiliki AppBar dan body. Di dalam body, terdapat Padding yang membungkus Column. Selanjutnya, Column memiliki beberapa child seperti Row, InfoCard, Text, dan GridView.count.

Dengan widget tree, struktur tampilan aplikasi menjadi lebih terorganisasi dan mudah dikelola.

**2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing.**

Beberapa widget bawaan Flutter yang digunakan dalam proyek MyPortfolio Mobile adalah:

| Widget | Fungsi |
|---|---|
| `MaterialApp` | Menyediakan konfigurasi dasar aplikasi berbasis Material Design, seperti tema dan halaman awal. |
| `Scaffold` | Menyediakan struktur dasar halaman, seperti AppBar dan body. |
| `AppBar` | Menampilkan bar di bagian atas halaman. |
| `Text` | Menampilkan teks. |
| `Padding` | Memberikan jarak antara child dan batas parent. |
| `Column` | Menyusun widget secara vertikal. |
| `Row` | Menyusun widget secara horizontal. |
| `Center` | Menempatkan child di tengah area yang tersedia. |
| `SizedBox` | Memberikan jarak atau menentukan ukuran tertentu. |
| `GridView.count` | Menampilkan kumpulan widget dalam susunan grid. |
| `Card` | Menampilkan informasi dalam bentuk kartu. |
| `Container` | Mengatur ukuran, padding, dan dekorasi suatu area. |
| `Material` | Menyediakan permukaan dengan tampilan Material Design. |
| `InkWell` | Memberikan respons interaksi ketika area ditekan. |
| `Icon` | Menampilkan ikon. |
| `SnackBar` | Menampilkan pesan sementara di bagian bawah layar. |

Selain widget bawaan Flutter, proyek ini juga menggunakan komponen dan class yang dibuat sendiri:

- `MyHomePage`: Custom widget yang menyusun tampilan utama aplikasi.
- `InfoCard`: Custom widget untuk menampilkan informasi mahasiswa.
- `ItemCard`: Custom widget untuk menampilkan tombol aksi yang dapat ditekan.
- `ItemHomepage`: Class model yang menyimpan data tombol, yaitu nama, ikon, dan warna. Class ini bukan widget, tetapi digunakan untuk memisahkan data dari implementasi tampilannya.

**3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter.**

MaterialApp merupakan widget yang menyediakan konfigurasi dasar aplikasi dengan Material Design. Widget ini mengatur beberapa hal seperti tema aplikasi, navigasi, dan halaman awal melalui properti home.

MaterialApp sering digunakan sebagai root widget karena menjadi titik awal struktur widget aplikasi. Dengan meletakkannya di bagian paling atas, konfigurasi Material Design dapat digunakan oleh widget-widget yang berada di bawahnya.

Pada proyek ini, MaterialApp membungkus halaman utama MyHomePage sehingga halaman tersebut dapat menggunakan komponen dan fitur Material Design seperti Scaffold, AppBar, dan SnackBar.

**4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

StatelessWidget adalah widget yang tidak memiliki state internal yang dapat berubah selama widget tersebut digunakan. Tampilan widget ditentukan oleh data atau konfigurasi yang diberikan kepadanya.

Sementara itu, StatefulWidget adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Perubahan state dapat menyebabkan widget membangun ulang tampilannya, biasanya melalui pemanggilan setState().

StatelessWidget cocok digunakan untuk tampilan yang relatif tetap, seperti halaman informasi atau kartu yang hanya menampilkan data. Sebaliknya, StatefulWidget cocok digunakan ketika tampilan perlu merespons perubahan data, seperti counter, form interaktif, atau tombol toggle.

Pada proyek ini, MyHomePage, InfoCard, dan ItemCard menggunakan StatelessWidget karena tidak membutuhkan pengelolaan state internal. Interaksi tombol hanya menampilkan SnackBar tanpa mengubah state tampilan halaman.

**5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

BuildContext merupakan referensi terhadap posisi suatu widget dalam widget tree. Melalui BuildContext, sebuah widget dapat mengakses informasi dan layanan yang tersedia dari widget-widget di atasnya.

BuildContext penting karena memungkinkan widget memperoleh konfigurasi atau informasi yang dibutuhkan dari ancestor-nya.

Dalam proyek ini, BuildContext digunakan pada metode build(BuildContext context). Contohnya, Theme.of(context) digunakan untuk memperoleh warna dari tema aplikasi, sedangkan MediaQuery.of(context) digunakan untuk memperoleh informasi ukuran layar.

Selain itu, ScaffoldMessenger.of(context) digunakan untuk mengakses ScaffoldMessenger sehingga aplikasi dapat menampilkan SnackBar ketika pengguna menekan tombol.

**6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

Hot reload merupakan fitur Flutter yang memungkinkan developer melihat perubahan kode pada aplikasi tanpa harus menjalankan ulang aplikasi dari awal. Hot reload umumnya mempertahankan state aplikasi yang sedang berjalan sehingga proses pengembangan menjadi lebih cepat.

Sementara itu, hot restart menjalankan ulang aplikasi dari awal dan menghapus state yang sebelumnya tersimpan. Hot restart diperlukan ketika perubahan kode tidak dapat diterapkan secara optimal melalui hot reload, misalnya ketika ingin menguji ulang proses inisialisasi aplikasi.

Full restart atau menjalankan ulang aplikasi sepenuhnya diperlukan untuk perubahan tertentu yang berkaitan dengan konfigurasi native, plugin, atau perubahan lingkungan yang tidak dapat diterapkan hanya dengan hot reload.

Dengan demikian, hot reload cocok untuk perubahan kode biasa, sedangkan hot restart dan full restart digunakan ketika perubahan membutuhkan inisialisasi ulang aplikasi atau proses native.

## AI Usage Disclosure

Dalam pengerjaan Individual Assignment 7 ini, saya menggunakan ChatGPT sebagai alat bantu belajar dan pengembangan aplikasi Flutter. Penggunaan AI bertujuan membantu memahami konsep, mengevaluasi implementasi, dan menyusun dokumentasi, bukan menggantikan proses pemahaman dan pengerjaan mandiri.

### Strategi Penggunaan AI

Saya menggunakan pendekatan bertahap dengan memberikan instruksi tugas, potongan kode yang sedang dikerjakan, serta kendala yang ditemukan. Strategi prompting yang digunakan meliputi:

- Memberikan requirement tugas agar AI dapat membantu mengidentifikasi fitur dan ketentuan yang harus dipenuhi.
- Memberikan potongan kode untuk meminta penjelasan mengenai struktur widget dan hubungan parent-child.
- Meminta penjelasan konsep Flutter dengan contoh yang relevan dengan implementasi proyek.
- Memberikan pesan error atau output terminal untuk membantu menganalisis kendala teknis.
- Meminta evaluasi terhadap dokumentasi dan jawaban refleksi agar sesuai dengan instruksi tugas.

### Bagian yang Dibantu oleh AI

ChatGPT digunakan untuk membantu:

- Memahami requirement Individual Assignment 7.
- Memahami konsep widget tree, StatelessWidget, StatefulWidget, BuildContext, hot reload, dan hot restart.
- Memberikan saran implementasi atribut warna pada model ItemHomepage dan penggunaannya pada ItemCard.
- Menganalisis kendala ketika menjalankan Flutter SDK dan flutter analyze.
- Menyusun dokumentasi, jawaban refleksi, dan struktur README.

### Evaluasi dan Verifikasi Mandiri

Saran yang diberikan AI tidak langsung digunakan tanpa pemeriksaan. Saya mempelajari kembali kode yang disarankan, menyesuaikannya dengan struktur proyek dan requirement tugas, serta melakukan pengujian terhadap implementasi.

Saya juga menjalankan flutter analyze untuk memeriksa kualitas kode. Hasil pemeriksaan menunjukkan bahwa tidak ditemukan issues.

Dalam proses penggunaan AI, saya menyadari bahwa jawaban yang dihasilkan dapat bersifat terlalu umum atau belum sepenuhnya sesuai dengan kondisi proyek. Oleh karena itu, saya tetap memeriksa kesesuaian setiap saran dengan kode aktual dan hasil pengujian.

Penggunaan AI membantu mempercepat proses pemahaman dan pemecahan masalah, tetapi keputusan implementasi, penyesuaian kode, serta verifikasi akhir tetap menjadi tanggung jawab saya.

### AI Conversation Log

Dokumentasi percakapan yang digunakan sebagai bantuan selama pengerjaan tugas:
https://chatgpt.com/share/6afb0b3e-9508-83ec-be6a-d88837e267fd



# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
