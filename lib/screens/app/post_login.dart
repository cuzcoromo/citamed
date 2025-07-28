import 'package:citamed/providers/post_login/post_login_providers.dart';
import 'package:citamed/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostLogin extends ConsumerStatefulWidget {
  const PostLogin({super.key});

  @override
  ConsumerState<PostLogin> createState() => _PostLoginState();
}

class _PostLoginState extends ConsumerState<PostLogin> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Health Hub'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              context.go('/login');
            },
            child: Text(
              'Sing in',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              context.go('/register');
            },
            child: Text('Sing up'),
          ),
          const SizedBox(width: 5),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHealthTips(),
                    // _builImages(theme),
                    _buildSectionTitle('Upcoming Appointments'),
                    const SizedBox(height: 10),

                    _builAppointmentCard(
                      ref,
                      context,
                      'Monday',
                      'Dr. Smith',
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuCxQ-2nTd8lbIWhN3_Ty5Y7J-UfasOSdEVIceP4cDnUnmYAWAeD0H6o47CPhyyfZb5XTuy2t0DqFS6ULUAZx_V7BmLbnCh7vQDYJaCiudPKfoumpIlNbjm889CZZ3TUHbCF8iStg6ASgxTfxgfgdkAzYUdcl-d6m5EqWKtCH474Q-fcAGTwJdKr70CdAjyp-yFseIUDcvMcLMuj2YQrKmNLvp0tUfvU4C73S_j75nlIABYK9YPYUR7YWpUMu0KggbMYwrnynyclz-Q",
                      theme,
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottonNav(),
    );
  }
}

Widget _buildHealthTips() {
  return SizedBox(
    height: 260,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      children: [
        _healthTipCard(
          "Stay Hydrated",
          "Drink plenty of water throughout the day.",
          "https://lh3.googleusercontent.com/aida-public/AB6AXuA_ITwGT0eeIpCjsJSnHUCkmuwpDqhkmcYBLmMQtl0EvFKZpSURO0Daair8JgTQ2n1P6jZZzMmz0sxnX9TC_LyrU3MkpWB_Cf2u1QeIIo7gOpNwj7T7uQINnzzjLdYeectO-NXNKK3KpdDIrdj_wkX-JuPNeMd40eBBIPYbU0aJEmhXowB16WwEbeSuTm6O2Qd5yrir6vwEfWmopBkdcSgLI1eK56EjB40M2If5lcU_PWrLpr5u9UKoiSElg6CLrj6kZ4QXET6LQzQ",
        ),
        _healthTipCard(
          "Healthy Eating",
          "Eat a balanced diet with fruits and vegetables.",
          "https://lh3.googleusercontent.com/aida-public/AB6AXuDNiCgt8_Hwzpb8iHjIJA5E-fDeeidtA6-ThTonEASPaoN9xjI6h4peTqBAYHQdr2sMOMxnEabKpnk1Q97jZh6dLMF7dGrNSRrVt6x5Nn_weQCCt_C0qYo3HSyZ2Yfhj2Ul6iTtkr-JOB9kClYecVDlMdiiUNSVQQesk54RYpOzs4GwGpQIIhRmh8PMKh7zvatSnmZQku12T4uIqP_Yvz1urLS1PhC1t0Af-ChACwGCLjdZcfHu7aJ7R5FV9cKcZ6J-yfhRUXl1axE",
        ),
        _healthTipCard(
          "Regular Exercise",
          "Engage in physical activity for at least 30 minutes daily.",
          "https://lh3.googleusercontent.com/aida-public/AB6AXuBGL6cAZKp_7UXxI1Tl9WPogYnVBMr_G-FFeP9EOBOdnCTgN-eFLTOQTYeIxBL5QXLZWx-CfoInfLUF225ry-B9xaPjezpdLj_1d2q9P3r_31JItbPO2RaStOG-OZWRgWVUDEsy0meyWnJ0K1p7faIpNpMjkVIa1bt4wcTliD_6JDsGeOGOccpxDtB-Be0MmJMu2KDZvLV3YEPiZ-kPnrAn4SGBjEv3VRujn8Snm9DzTkwSnxGrBK0gR5AgPu0KsYHS0_7zbZjCrrk",
        ),
      ],
    ),
  );
}

Widget _healthTipCard(String title, String subtitle, String imageUrl) {
  return Container(
    width: 120,
    margin: const EdgeInsets.only(right: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF111418),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Color(0xFF60758a)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
    child: Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _builAppointmentCard(
  WidgetRef ref,
  BuildContext context,
  String day,
  String info,
  String imageUrl,
  ThemeData theme,
) {
  final AsyncValue<List<Doctor>> doctors = ref.watch(getListDoctorsProvider);
  if (doctors.isLoading) {
    return const Center(child: CircularProgressIndicator());
  }
  if (doctors.hasError) {
    return const Center(child: Text('No data'));
  }
  final data = doctors.value!;

  return Column(
    children:
        data.map((doctor) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(day, style: TextStyle(color: Color(0xFF60758a))),
                      Text(
                        'Dr. ${doctor.nombre} ${doctor.apellido}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Cardiologo',
                        style: TextStyle(color: Color(0xFF60758a)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
  );
}

// Widget _buildBottonNav() {
//   return BottomNavigationBar(
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: Colors.grey.shade400,
//     unselectedItemColor: Colors.grey.shade600,
//     items: const [
//       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.calendar_month),
//         label: 'Calendar',
//       ),
//       BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
//       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//     ],
//   );
// }
