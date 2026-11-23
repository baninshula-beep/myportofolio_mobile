import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan data riwayat pendidikan baru.
/// Menggunakan StatefulWidget untuk mengelola status validasi formulir,
/// interaksi input pengguna, dan siklus hidup pembersihan state.
class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  // GlobalKey<FormState> digunakan untuk mengidentifikasi widget Form secara unik
  // dan memberikan akses ke objek FormState untuk menjalankan validasi (validate())
  // serta mengembalikan kondisi form ke awal (reset()).
  final _formKey = GlobalKey<FormState>();

  // Variabel penampung nilai input formulir.
  // Nilai disimpan langsung melalui callback onChanged tanpa setState()
  // untuk menghindari rebuild widget tree yang tidak diperlukan pada setiap ketikan tombol.
  String _institution = "";
  String _degree = "Sarjana (S1)"; // Nilai default dropdown
  String _major = "";
  String _graduationYear = "";
  String _description = "";

  // Opsi pilihan jenjang pendidikan untuk widget DropdownButtonFormField.
  final List<String> _degrees = [
    'SMA/SMK',
    'Diploma (D3/D4)',
    'Sarjana (S1)',
    'Magister (S2)',
    'Doktor (S3)',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Education Form',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        // SingleChildScrollView digunakan agar seluruh konten formulir dapat digulir
        // secara vertikal saat keyboard virtual tampil atau pada perangkat berlayar sempit,
        // sehingga mencegah terjadinya error RenderFlex overflow.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Institusi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: "Nama Institusi / Universitas",
                    labelText: "Nama Institusi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _institution = value ?? "";
                  },
                  // Validator memeriksa keberadaan nilai (wajib diisi, tolak spasi kosong)
                  // serta memastikan panjang teks tidak melampaui batas wajar 100 karakter.
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama institusi tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Nama institusi tidak boleh lebih dari 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Jenjang Pendidikan ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Jenjang Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _degree,
                  items: _degrees
                      .map((degree) => DropdownMenuItem(
                            value: degree,
                            child: Text(degree),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _degree = newValue;
                    }
                  },
                ),
              ),

              // === Jurusan / Program Studi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: "Contoh: Ilmu Komputer, Sistem Informasi",
                    labelText: "Jurusan / Program Studi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _major = value ?? "";
                  },
                  // Validator memastikan jurusan wajib diisi dan memiliki panjang maksimal 100 karakter.
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Jurusan tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Jurusan tidak boleh lebih dari 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tahun Kelulusan ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Contoh: 2026",
                    labelText: "Tahun Kelulusan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _graduationYear = value ?? "";
                  },
                  // Validator memeriksa kelengkapan isian, memastikan format numerik murni,
                  // serta mengharuskan input tepat 4 digit angka sebagai representasi tahun valid.
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tahun kelulusan tidak boleh kosong!";
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return "Tahun kelulusan harus berupa angka!";
                    }
                    if (value.trim().length != 4) {
                      return "Tahun kelulusan harus terdiri dari 4 digit angka!";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi / Capaian Akademik ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 500,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Deskripsi kegiatan, konsentrasi, atau fokus studi (opsional)",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _description = value ?? "";
                  },
                  // Field ini bersifat opsional, namun validator menjaga agar panjang teks
                  // tidak melebihi batas penyimpanan maksimal 500 karakter.
                  validator: (String? value) {
                    if (value != null && value.trim().length > 500) {
                      return "Deskripsi tidak boleh lebih dari 500 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      // FormState.validate() menjalankan seluruh validator field di bawah Form.
                      // Mengembalikan true hanya jika semua validator mengembalikan nilai null (lolos validasi).
                      if (_formKey.currentState!.validate()) {
                        // Jika validasi sukses, tampilkan AlertDialog sebagai ringkasan isian pengguna.
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Edukasi berhasil ditambahkan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Institusi: $_institution'),
                                    Text('Jenjang: $_degree'),
                                    Text('Jurusan: $_major'),
                                    Text('Tahun Kelulusan: $_graduationYear'),
                                    Text('Deskripsi: ${_description.trim().isEmpty ? "-" : _description}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    // 1. Menutup dialog ringkasan
                                    Navigator.pop(context);

                                    // 2. Mengatur ulang tampilan input field pada Form widget
                                    _formKey.currentState!.reset();

                                    // 3. Mereset seluruh variabel penampung state ke nilai awal
                                    //    agar pop-up berikutnya tidak menampilkan data residu lama.
                                    setState(() {
                                      _institution = "";
                                      _degree = "Sarjana (S1)";
                                      _major = "";
                                      _graduationYear = "";
                                      _description = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
