import 'package:citamed/providers/controllers/form_controller.dart';
import 'package:citamed/providers/medico/register/registro_medico_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterDoctor extends ConsumerStatefulWidget {
  const RegisterDoctor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends ConsumerState<RegisterDoctor> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _licenseController = TextEditingController();

  bool _isValid = false;

  void _validate() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validate);
    _apellidoController.addListener(_validate);
    _phoneController.addListener(_validate);
    _emailController.addListener(_validate);
    _licenseController.addListener(_validate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _apellidoController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(messageProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next)));
        ref.read(messageProvider.notifier).state = null; // resetear mensaje
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Registro de Mèdico'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Información Básica',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Empecemos con tus datos personales y profesionales.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _buildInputField('Nombres', _nameController, 'Ana Ana'),
              _buildInputField(
                'Apellidos',
                _apellidoController,
                'Torres Torres',
              ),
              _buildInputField(
                'Número de celular',
                _phoneController,
                '0912345678',
                type: TextInputType.phone,
                validator: _validatePhone,
              ),
              _buildInputField(
                'Correo electrónico',
                _emailController,
                'Ej: ana@email.com',
                type: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              _buildInputField(
                'Nùmero de registro',
                _licenseController,
                validator: _validateLicencia,
                '1234-...',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final isLoading = ref.watch(isLoadingProvider);
            return ElevatedButton(
              onPressed:
                  isLoading
                      ? null
                      : () async {
                        final input = {
                          'nombre': _nameController.text,
                          'apellido': _apellidoController.text,
                          'email': _emailController.text.trim().toLowerCase(),
                          'num_celular': _phoneController.text,
                          'num_registro': _licenseController.text,
                        };
                        ref.read(isLoadingProvider.notifier).state = true;

                        try {
                          await ref.watch(
                            registrarDoctorProvider(input).future,
                          );
                          ref.read(messageProvider.notifier).state =
                              'Doctor registrado con éxito';
                        } catch (e) {
                          ref.read(messageProvider.notifier).state = '$e';
                        } finally {
                          ref.read(isLoadingProvider.notifier).state = false;
                        }
                      },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeAlign: 2,
                        ),
                      )
                      : const Text(
                        'Siguiente',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
            );
          },
        ),
      ),
    );
  }
}
// 1002-2021-239-987

Widget _buildInputField(
  String label,
  TextEditingController controller,
  String placeholder, {
  TextInputType type = TextInputType.text,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: type,
          maxLength: (type == TextInputType.phone) ? 10 : null,
          decoration: InputDecoration(
            hintText: placeholder,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          validator:
              validator ??
              (value) =>
                  value == null || value.isEmpty ? 'Campo obligatorio' : null,
        ),
      ],
    ),
  );
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Campo obligatorio';
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value) ? null : 'Introduce un correo válido.';
}

String? _validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) return 'Campo obligatorio';
  final cleaned = value.trim().replaceAll(' ', '');
  final phoneRegex = RegExp(r'^\d{10}$');
  return phoneRegex.hasMatch(cleaned) ? null : 'Introduce un número válido';
}

String? _validateLicencia(String? value) {
  if (value == null || value.isEmpty) return 'Campo obligatorio';
  final licenciaRegex = RegExp(r'^\d{4}-\d{4}-\d{3}-\d{3}$');
  return licenciaRegex.hasMatch(value) ? null : 'Formato invalido';
}
