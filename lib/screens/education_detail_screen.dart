import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

/// Displays detailed information for a single [Education] entry fetched by ID.
class EducationDetailScreen extends StatefulWidget {
  const EducationDetailScreen({
    required this.educationId,
    this.apiClient,
    super.key,
  });

  final int educationId;
  final ApiClient? apiClient;

  @override
  State<EducationDetailScreen> createState() => _EducationDetailScreenState();
}

class _EducationDetailScreenState extends State<EducationDetailScreen> {
  late final ApiClient _apiClient;
  late Future<Education> _educationFuture;

  @override
  void initState() {
    super.initState();
    _apiClient = widget.apiClient ?? context.read<ApiClient>();
    _educationFuture = _apiClient.getEducationDetail(widget.educationId);
  }

  Future<void> _reload() async {
    final future = _apiClient.getEducationDetail(widget.educationId);
    setState(() {
      _educationFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Education Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Education>(
        future: _educationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gagal memuat detail pendidikan: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final education = snapshot.data;
          if (education == null) {
            return const Center(
              child: Text('Data pendidikan tidak ditemukan.'),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        education.institution,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        education.degree,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Divider(height: 24.0),
                      _DetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Periode',
                        value: education.year,
                      ),
                      const SizedBox(height: 12.0),
                      _DetailRow(
                        icon: Icons.school_outlined,
                        label: 'Tahun Kelulusan',
                        value: education.graduationYear?.toString() ?? '-',
                      ),
                      const SizedBox(height: 12.0),
                      _DetailRow(
                        icon: Icons.star_outline,
                        label: 'Jumlah Star',
                        value: '${education.starCount}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.0, color: Colors.indigo),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(value, style: const TextStyle(fontSize: 15.0)),
            ],
          ),
        ),
      ],
    );
  }
}
