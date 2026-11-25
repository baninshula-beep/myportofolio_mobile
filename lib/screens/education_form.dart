import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/screens/education_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

/// Halaman formulir untuk menambahkan data riwayat pendidikan baru ke backend DRF.
class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = '';
  String _degree = '';
  String _year = '';
  String _graduationYear = '';
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final allowed = await ensureLoggedIn(context);
    if (!mounted || !allowed) {
      return;
    }

    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null || token.isEmpty) {
      return;
    }

    final trimmedGradYear = _graduationYear.trim();
    final int? parsedGradYear = trimmedGradYear.isEmpty
        ? null
        : int.parse(trimmedGradYear);

    final newEducation = Education(
      institution: _institution.trim(),
      degree: _degree.trim(),
      year: _year.trim(),
      graduationYear: parsedGradYear,
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final created = await context.read<ApiClient>().createEducation(
        newEducation,
        token: token,
      );
      if (!mounted) {
        return;
      }

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Edukasi berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Institusi: ${created.institution}'),
                  Text('Gelar / Prodi: ${created.degree}'),
                  Text('Tahun / Periode: ${created.year}'),
                  Text(
                    'Tahun Kelulusan: ${created.graduationYear?.toString() ?? '-'}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        },
      );

      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EducationListScreen()),
      );
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }

      if (error.statusCode == 401) {
        await authState.logout();
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Sesi login berakhir atau token tidak valid. Silakan login ulang.',
              ),
            ),
          );
        return;
      }

      final message = error.statusCode == 403
          ? 'Akses ditolak: hanya pemilik portofolio (superuser) yang dapat menambah data.'
          : 'Gagal menyimpan edukasi: ${error.message}';

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Institusi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Universitas Indonesia',
                    labelText: 'Nama Institusi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String value) {
                    _institution = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama institusi tidak boleh kosong!';
                    }
                    if (value.trim().length > 100) {
                      return 'Nama institusi tidak boleh lebih dari 100 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Gelar / Program Studi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: 'Contoh: S1 Sistem Informasi',
                    labelText: 'Gelar / Program Studi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String value) {
                    _degree = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Gelar / Program Studi tidak boleh kosong!';
                    }
                    if (value.trim().length > 100) {
                      return 'Gelar / Program Studi tidak boleh lebih dari 100 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tahun / Periode ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 2024 - Present',
                    labelText: 'Tahun / Periode',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String value) {
                    _year = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tahun / Periode tidak boleh kosong!';
                    }
                    if (value.trim().length > 20) {
                      return 'Tahun / Periode tidak boleh lebih dari 20 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tahun Kelulusan (Opsional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 2028 (opsional)',
                    labelText: 'Tahun Kelulusan (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String value) {
                    _graduationYear = value;
                  },
                  validator: (String? value) {
                    final trimmed = value?.trim() ?? '';
                    if (trimmed.isEmpty) {
                      return null;
                    }
                    if (int.tryParse(trimmed) == null) {
                      return 'Tahun kelulusan harus berupa angka!';
                    }
                    if (trimmed.length != 4) {
                      return 'Tahun kelulusan harus terdiri dari 4 digit angka!';
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
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
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
