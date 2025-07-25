import 'package:citamed/providers/auth/login_provider.dart';
import 'package:citamed/theme_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CitaMed'),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(loginProvider.notifier).logout();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          children: [
            const SizedBox(height: 20),
            _builWelcome(ref, theme),
            const SizedBox(height: 20),
            Center(child: _buildImage()),
            const SizedBox(height: 20),
            _buildSearch(context),
            const SizedBox(height: 20),
            _buildRegisterMedico(context),
            const SizedBox(height: 40),
            Text('Lista de citas'),
          ],
        ),
      ),
    );
  }
}

Widget _builWelcome(WidgetRef ref, ThemeData theme) {
  final data = ref.read(loginProvider);
  if (data.status == LoginStatus.loading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: 100, height: 20, color: Colors.grey.shade200),
    );
  }
  if (data.status == LoginStatus.error || data.user == null) {
    return Text('No data');
  }
  final user = data.user!.username;
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Bienvenida/o, $user',
          textAlign: TextAlign.center,
          style: TextStyle(
            // color: theme.colorScheme.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Estamos encantadod e tenerte aquì.',
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.colorScheme.text2, fontSize: 15),
        ),
        Text(
          'Empecemos por programar tu primera cìta mèdica.',
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.colorScheme.text2, fontSize: 15),
        ),
      ],
    ),
  );
}

Widget _buildImage() {
  return SizedBox(
    width: 100,
    height: 100,
    child: Card(
      child: Center(
        child: Image.asset('assets/images/person.png', width: 100, height: 100),
      ),
    ),
  );
}

Widget _buildSearch(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Busca un mèdico',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Emcuentra al especialista perfecto por nombre, especialidad o ubicaciòn.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        _buildButton(context),
      ],
    ),
  );
}

Widget _buildButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue.shade500),
      ),
      onPressed: () {
        context.push('/medicos');
        // context.go('/medicos');
      },
      child: Text(
        'Buscar ahora',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}

Widget _buildRegisterMedico(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '¿Eres Medico? ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'Registrate aquí',
            style: TextStyle(
              color: Colors.blue[500],
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.push('/re-medico');
                  },
          ),
        ],
      ),
    ),
  );
}
