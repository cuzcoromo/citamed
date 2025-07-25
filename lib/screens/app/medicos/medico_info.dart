import 'package:citamed/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MedicoInfo extends ConsumerStatefulWidget {
  const MedicoInfo({super.key});

  @override
  ConsumerState<MedicoInfo> createState() => _MedicoInfoState();
}

class _MedicoInfoState extends ConsumerState<MedicoInfo> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil del Médico'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/unnamed.png'),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Dr.Elena Ramirez',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Column(
              children: [
                Text('Cardiólogo'),
                Text(
                  '12 años de experiencia',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey.shade400, width: 1),
                        padding: EdgeInsets.all(8),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.phone,
                        color: theme.colorScheme.iconColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey.shade400, width: 1),
                        padding: EdgeInsets.all(8),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('user@user.com'),
                                ),
                              ),
                        );
                      },
                      child: Icon(
                        Icons.email_outlined,
                        color: theme.colorScheme.iconColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Text(
            'Servicios Disponibles',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildServicios(context, theme),
        ],
      ),
    );
  }
}

Widget _buildServicios(BuildContext context, ThemeData theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Card(
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Consulta Cardiologica general',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => Dialog(
                          // alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 920),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Seleccionar fecha y hora',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Servicio',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const SizedBox(height: 10),
                                  ListTile(
                                    title: Text(
                                      'Consulta medica',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text('Consulta general '),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Ubicaciòn',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const SizedBox(height: 10),
                                  ListTile(
                                    title: Text(
                                      'Centro medico',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text('Clinica de salud'),
                                  ),
                                  _buildHorario(),
                                  Text(
                                    'Horarios Diponibles',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  _buildHora(),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: _buldButton(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: Colors.blue.shade300, width: 1),
                ),
                child: Text(
                  'Reservar',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Consultorio Principal - Calle Falsa 123',
                      style: TextStyle(
                        color: theme.colorScheme.text2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Lunes,Miercoles, Vienes  9:00 AM - 5:00 PM',
                      style: TextStyle(
                        color: theme.colorScheme.text2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Icon(Icons.calendar_today),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      'Martes, Jueves  9:00 AM - 5:00 PM',
                      style: TextStyle(
                        color: theme.colorScheme.text2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildHorario() {
  final DateTime now = DateTime.now();
  final DateTime initialDate = now;
  final DateTime firstDate = now;
  final DateTime lastDate = now.add(const Duration(days: 30));

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CalendarDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateChanged: (selectedDate) {
        // Puedes manejar la fecha seleccionada aquí
        print('Fecha seleccionada: $selectedDate');
      },
    ),
  );
}

Widget _buildHora() {
  final List<String> horas = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];
  String? horaSeleccionada;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Wrap(
      spacing: 8,
      children:
          horas.map((hora) {
            final bool isSelected = hora == horaSeleccionada;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
                foregroundColor: isSelected ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                setState() {
                  horaSeleccionada = hora;
                }
              },
              child: Text(hora),
            );
          }).toList(),
    ),
  );
}

Widget _buldButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        context.push('/det-cita');
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[400]),
      child: Text(
        'Continuar',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );
}
