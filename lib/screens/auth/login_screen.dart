import 'package:citamed/providers/auth/login_provider.dart';
import 'package:citamed/screens/auth/register_screen.dart';
import 'package:citamed/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flash/flash.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isPaswordVisible = true;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // padding: const EdgeInsets.all(16.0),
            children: [
              _buildImages(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTextFields(state),
              ),
              const SizedBox(height: 20),
              _buildRegisteraButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // el formulario de login aqui por el estado del widget
  Widget _buildTextFields(LoginState state) {
    // if (state.status == LoginStatus.loading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    if (state.status == LoginStatus.error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showFlash(
          context: context,
          duration: const Duration(seconds: 3),
          builder: (_, controller) {
            return Flash(
              controller: controller,
              position: FlashPosition.top,
              child: FlashBar(
                title: const Text(
                  'Error',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  'Error al loguearse ',
                  style: TextStyle(color: Colors.white),
                ),
                indicatorColor: Colors.red, // Color de la barra lateral
                backgroundColor: Colors.red.shade500,
                icon: const Icon(Icons.error, color: Colors.white),
                shouldIconPulse: true,
                controller: controller,
              ),
            );
          },
        );
      });
    }
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailcontroller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Email',
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo requerido';
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Email no válido';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordcontroller,
            obscureText: isPaswordVisible,
            decoration: InputDecoration(
              hintText: 'password',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryColor,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPaswordVisible = !isPaswordVisible;
                  });
                },
                icon: Icon(
                  isPaswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                ),
              ),
            ),
            // validador
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo requerido';
              }
              return null;
            },
          ),
          SizedBox(width: double.infinity, child: _buildLoginButton(state)),
        ],
      ),
    );
  }

  Widget _buildLoginButton(LoginState state) {
    final isLoading = state.status == LoginStatus.loading;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed:
          isLoading
              ? null
              : () {
                if (_formkey.currentState?.validate() ?? false) {
                  final email = emailcontroller.text.trim();
                  final password = passwordcontroller.text.trim();
                  ref
                      .read(loginProvider.notifier)
                      .loginquery(email: email, password: password);
                }
              },
      child:
          isLoading
              ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
    );
  }
}

Widget _buildImages() {
  return SizedBox(
    width: double.infinity,
    height: 200,
    child: Image.asset('assets/images/login.jpg', fit: BoxFit.cover),
  );
}

Widget _buildRegisteraButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.go('/post-login');
    },
    child: RichText(
      text: TextSpan(
        text: 'Don`t have account? ',
        style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        children: [
          TextSpan(
            text: 'Registar',
            style: TextStyle(
              color: Colors.blue.shade400,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
