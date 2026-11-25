import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/education_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

/// A reusable interactive card representing a homepage action.
///
/// Uses the ItemHomepage model to determine its label, icon,
/// and background color. When tapped, it displays a SnackBar
/// containing the name of the selected action, and navigates
/// to ProjectFormPage or EducationFormPage when their respective card is selected.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          // Menampilkan feedback interaksi menggunakan SnackBar.
          // hideCurrentSnackBar() dipanggil agar interaksi tombol terbaru langsung terlihat.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );

          // Navigasi ke halaman form yang sesuai dengan tombol yang ditekan.
          // Menggunakan Navigator.push() dengan MaterialPageRoute agar rute baru
          // ditumpuk di atas stack navigasi sehingga pengguna dapat kembali ke
          // homepage menggunakan tombol Back sistem pada perangkat atau browser.
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectFormPage()),
            );
          } else if (item.name == "Lihat Education") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationListScreen(),
              ),
            );
          } else if (item.name == "Add Education") {
            final allowed = await ensureLoggedIn(context);
            if (!context.mounted || !allowed) {
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationFormPage(),
              ),
            );
          } else if (item.name == "Logout") {
            final authState = context.read<AuthState>();
            final messenger = ScaffoldMessenger.of(context);
            final navigator = Navigator.of(context);

            if (!authState.isLoggedIn) {
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Kamu belum login. Mengarahkan ke Login...'),
                  ),
                );
              navigator.push(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              return;
            }

            await authState.logout();
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('Berhasil logout.')));
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
