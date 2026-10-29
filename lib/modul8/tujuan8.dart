import 'package:flutter/material.dart';
import 'screen8.dart';

class Tujuan8 extends StatelessWidget {
  const Tujuan8({super.key});

  static const String routeName = '/tujuan8';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ScreenArguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF94A29),
      appBar: AppBar(
        title: const Text('Detail Game'),
        backgroundColor: const Color(0xFFF94A29),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: const Color(0xFFF4F8FB),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      args.cover,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 220,
                          child: Icon(
                            Icons.videogame_asset,
                            size: 70,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      args.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002F48),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      args.shortDesc,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF002F48),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      args.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF002F48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Game'),
            ),
          ],
        ),
      ),
    );
  }
}