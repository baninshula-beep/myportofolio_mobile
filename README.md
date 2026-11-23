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





### Tugas 8

**1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Kapan masing-masing metode digunakan dalam proyek ini?**

Ketiga metode tersebut digunakan untuk mengatur perpindahan halaman atau route dalam aplikasi Flutter.

- `Navigator.push()` digunakan untuk membuka halaman baru di atas halaman yang sedang aktif tanpa menghapus halaman sebelumnya dari navigation stack. Dengan demikian, pengguna dapat kembali ke halaman sebelumnya menggunakan tombol Back.
- `Navigator.pushReplacement()` digunakan untuk membuka halaman baru sekaligus menggantikan halaman yang sedang aktif. Halaman sebelumnya tidak lagi menjadi bagian dari navigation stack.
- `Navigator.pop()` digunakan untuk menutup halaman atau route yang sedang aktif dan kembali ke halaman sebelumnya. Metode ini juga dapat digunakan untuk menutup dialog.

Dalam proyek MyPortfolio Mobile, `Navigator.push()` digunakan ketika pengguna menekan card Add Education pada homepage. Dengan demikian, setelah membuka EducationFormPage, pengguna dapat kembali ke homepage melalui tombol Back.

Sementara itu, `Navigator.pushReplacement()` digunakan pada menu Add Education di Drawer. Metode ini menggantikan halaman yang sedang aktif dengan EducationFormPage. `Navigator.pop()` digunakan ketika pengguna menekan tombol OK pada AlertDialog untuk menutup dialog ringkasan data pendidikan.

**2. Jelaskan fungsi widget `Scaffold`, `AppBar`, dan `Drawer` dalam membangun struktur halaman Flutter. Bagaimana ketiganya digunakan dalam proyek ini?**

`Scaffold` merupakan widget yang menyediakan struktur dasar halaman aplikasi berbasis Material Design. Scaffold menyediakan beberapa bagian seperti AppBar, Drawer, dan body sehingga tampilan halaman dapat disusun secara terorganisasi.

`AppBar` merupakan bagian yang ditampilkan di atas halaman. Widget ini biasanya digunakan untuk menampilkan judul halaman serta menyediakan area untuk tindakan atau navigasi.

`Drawer` merupakan panel navigasi yang dapat dibuka dari sisi layar. Drawer umumnya berisi pilihan menu yang membantu pengguna berpindah ke halaman lain dalam aplikasi.

Dalam proyek MyPortfolio Mobile, ketiga widget tersebut digunakan pada halaman homepage maupun EducationFormPage. Scaffold menjadi struktur utama setiap halaman, AppBar menampilkan judul halaman, sedangkan Drawer menyediakan navigasi menuju Home, Add Project, dan Add Education.

Dengan menggunakan struktur tersebut, tampilan dan navigasi aplikasi menjadi lebih konsisten serta memudahkan pengguna mengakses fitur yang tersedia.

**3. Jelaskan widget layout yang digunakan dalam form. Bagaimana widget tersebut mengatur posisi dan jarak elemen, serta bagaimana `SingleChildScrollView` membantu tampilan menyesuaikan ukuran layar dan keyboard?**

Widget layout digunakan untuk mengatur posisi, ukuran, jarak, dan susunan elemen pada halaman Flutter.

Dalam EducationFormPage, beberapa widget layout yang digunakan adalah:

- `Column`: menyusun elemen formulir secara vertikal dari atas ke bawah.
- `Padding`: memberikan jarak antara elemen formulir dengan batas area di sekitarnya.
- `Align`: mengatur posisi tombol Save agar berada di bagian tengah bawah area formulir.
- `SingleChildScrollView`: memungkinkan seluruh konten formulir digulir secara vertikal.

Penggunaan `SingleChildScrollView` penting karena formulir terdiri dari beberapa input yang membutuhkan ruang cukup besar. Ketika keyboard muncul atau aplikasi dibuka pada perangkat dengan ukuran layar lebih kecil, sebagian konten mungkin tidak dapat ditampilkan sekaligus.

Dengan adanya kemampuan scrolling, pengguna tetap dapat mengakses seluruh field dan tombol Save tanpa mengalami masalah tampilan seperti overflow. Hal ini membuat formulir lebih fleksibel digunakan pada berbagai ukuran layar.

**4. Jelaskan fungsi `GlobalKey<FormState>`, `FormState`, `validator`, dan `validate()` dalam validasi form. Mengapa penggunaan `keyboardType: TextInputType.number` saja belum cukup untuk memastikan input tahun kelulusan valid?**

Dalam Flutter, validasi form dilakukan untuk memastikan data yang dimasukkan pengguna memenuhi ketentuan sebelum diproses lebih lanjut.

`GlobalKey<FormState>` digunakan untuk mengidentifikasi widget Form secara unik dan memberikan akses kepada FormState. Melalui key tersebut, aplikasi dapat menjalankan proses validasi maupun reset terhadap seluruh field di dalam Form.

`FormState` merupakan state yang dikelola oleh widget Form. Salah satu metode yang dimilikinya adalah `validate()`, yang menjalankan seluruh fungsi validator pada field yang berada di dalam Form. Jika semua field lolos validasi, metode tersebut mengembalikan nilai `true`. Sebaliknya, jika terdapat field yang tidak memenuhi ketentuan, metode tersebut mengembalikan nilai `false` dan menampilkan pesan kesalahan pada field terkait.

`validator` merupakan fungsi yang digunakan untuk menentukan aturan validasi setiap input. Fungsi ini mengembalikan pesan kesalahan apabila input tidak memenuhi ketentuan atau `null` apabila input dinyatakan valid.

Dalam EducationFormPage, validasi diterapkan pada beberapa field. Institution dan Major wajib diisi dengan batas maksimal 100 karakter. Graduation Year wajib diisi dan harus terdiri dari tepat empat digit angka. Sementara itu, Description bersifat opsional dengan batas maksimal 500 karakter.

Penggunaan `keyboardType: TextInputType.number` saja belum cukup untuk memastikan input tahun kelulusan valid. Properti tersebut hanya mengatur jenis keyboard yang ditampilkan kepada pengguna, bukan membatasi atau memvalidasi data yang dimasukkan. Pengguna masih dapat memasukkan data yang tidak sesuai melalui metode input lainnya.

Oleh karena itu, diperlukan validator tambahan untuk memeriksa apakah input tidak kosong, dapat dikonversi menjadi angka, dan memiliki tepat empat digit. Dengan demikian, aplikasi dapat memastikan data memenuhi aturan sebelum menampilkan AlertDialog yang berisi ringkasan informasi pendidikan.

### AI Usage Disclosure

Dalam pengerjaan Individual Assignment 8 ini, saya menggunakan ChatGPT dan Antigravity sebagai alat bantu dalam proses pembelajaran dan pengembangan aplikasi Flutter. Penggunaan AI dilakukan untuk membantu memahami requirement, mempelajari konsep, mengimplementasikan fitur, menganalisis kode, serta mengevaluasi hasil pengerjaan.

#### Strategi Penggunaan AI

Saya menggunakan pendekatan bertahap dengan memberikan instruksi tugas, struktur project, potongan kode, dan hasil pengujian kepada AI. Strategi yang digunakan meliputi:

- Memberikan requirement IA8 untuk membantu mengidentifikasi fitur dan ketentuan yang harus dipenuhi.
- Meminta ChatGPT menjelaskan konsep Flutter Navigation, layout, form, dan input elements dengan contoh yang relevan dengan project.
- Meminta ChatGPT membantu menyusun tahapan implementasi agar perubahan dapat dilakukan secara terstruktur.
- Menggunakan Antigravity untuk memeriksa struktur project dan membantu mengimplementasikan perubahan kode berdasarkan instruksi yang diberikan.
- Memberikan output terminal dan kode kepada ChatGPT untuk memperoleh evaluasi serta mengidentifikasi potensi masalah.
- Meminta bantuan AI dalam menyusun dokumentasi dan jawaban refleksi berdasarkan implementasi aktual.

#### Bagian yang Dibantu oleh AI

ChatGPT digunakan untuk membantu memahami requirement IA8, menjelaskan konsep `Navigator`, `Scaffold`, `AppBar`, `Drawer`, widget layout, `Form`, `GlobalKey<FormState>`, dan validasi input. ChatGPT juga membantu mengevaluasi implementasi kode, menjelaskan fungsi setiap bagian, serta menyusun dokumentasi refleksi.

Antigravity digunakan untuk membantu memeriksa struktur project, mengimplementasikan EducationFormPage, mengintegrasikan navigasi Education pada homepage dan Drawer, serta menjalankan pemeriksaan menggunakan `flutter analyze`.

#### Evaluasi dan Verifikasi Mandiri

Saran dan perubahan kode yang dihasilkan AI tidak langsung diterima tanpa pemeriksaan. Saya mempelajari kembali implementasi yang dibuat, meninjau perubahan pada setiap file, dan memastikan bahwa fitur yang ditambahkan sesuai dengan requirement tugas.

Saya juga melakukan pengujian secara manual melalui Chrome, termasuk menguji navigasi dari homepage dan Drawer, validasi input kosong maupun tidak sesuai, pengiriman data yang valid, serta tampilan AlertDialog dan proses reset formulir. Selain itu, saya menjalankan `flutter analyze` untuk memeriksa kualitas kode dan memastikan tidak ditemukan issues.

Melalui proses ini, saya memahami bahwa AI dapat membantu mempercepat proses pembelajaran dan pengembangan, tetapi hasil yang diberikan tetap perlu diperiksa dan diverifikasi. Keputusan implementasi, pemahaman terhadap kode, pengujian, serta tanggung jawab atas hasil akhir tetap berada pada saya.

#### AI Conversation Log

Dokumentasi percakapan yang digunakan sebagai bantuan selama pengerjaan tugas:

https://chatgpt.com/share/6b03fbda-7cec-83ec-8836-4082f4ee5a23



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
