import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MedicosScreen extends ConsumerStatefulWidget {
  const MedicosScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MedicosScreenState();
}

class _MedicosScreenState extends ConsumerState<MedicosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Buscar Mèdicos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, especialidad...',
                prefixIcon: Icon(Icons.search_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              color: Colors.grey.shade100,
              child: ListTile(
                leading: CircleAvatar(child: Text('Dr.')),
                trailing: Icon(Icons.chevron_right),
                title: Text(
                  'Dr. Jose Maria...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('Especialidad: Cardiologo'),
                onTap: () {
                  context.push('/doc-info');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
