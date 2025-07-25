import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitaScreen extends ConsumerStatefulWidget {
  const CitaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CitaScreenState();
}

class _CitaScreenState extends ConsumerState<CitaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Detalles de la cita'))),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Center(child: const Text('Consulta de Cardiologia')),
            const SizedBox(height: 20),
            _buildOneSection(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }
}

Widget _buildOneSection() {
  return Column(
    children: [
      ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/unnamed.png'),
        ),
        title: Text(
          'Dr.Ricardo Garcia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Cardiologo'),
      ),
      ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(
          'Lunes 15 de Juelio, 2025',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('10:00M'),
      ),
      ListTile(
        leading: Icon(Icons.location_pin),
        title: Text(
          'Clinica del corazon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Av. Priincipal 123 2do piso'),
      ),
      const SizedBox(height: 10),
      ListTile(
        title: Text(
          'Notas Importantes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        subtitle: Text('Por, favor llegue 15 minutos antes de su cita'),
      ),
      const SizedBox(height: 10),
      ListTile(
        title: Text(
          'Contacto del consultorio',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                Icon(Icons.phone_outlined, color: Colors.grey.shade500),
                const SizedBox(width: 6),
                Expanded(child: Text('+593 892737364')),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email_outlined, color: Colors.grey.shade500),
                const SizedBox(width: 6),
                Expanded(child: Text('info@clinicadelcorazon.com')),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildButtons() {
  return Column(
    children: [
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[300],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // backgroundColor: Colors.
          ),
          onPressed: () {},
          child: Text(
            'Añadir al calendario',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Reprogramar',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.red[600],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
