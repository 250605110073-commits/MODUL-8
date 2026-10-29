import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screen8.dart';
import 'tujuan8.dart';

class Home8 extends StatefulWidget {
  const Home8({super.key});

  @override
  State<Home8> createState() => _Home8State();
}

class _Home8State extends State<Home8> {
  Map<String, dynamic>? game;
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getGame();
  }

  Future<void> getGame() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.freetogame.com/api/game?id=475'),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal mengambil data game');
      }

      final result = jsonDecode(response.body);

      if (!mounted) return;

      setState(() {
        game = result as Map<String, dynamic>;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Data gagal dimuat. Periksa koneksi internet.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081C9),
      appBar: AppBar(
        title: const Text('Game Explorer'),
        backgroundColor: const Color(0xFF0081C9),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : errorMessage != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                            errorMessage = null;
                          });
                          getGame();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  )
                : buildGameCard(),
      ),
    );
  }

  Widget buildGameCard() {
    final data = game!;
    final thumbnail = data['thumbnail']?.toString() ?? '';

    final screenshots = data['screenshots'];
    String cover = thumbnail;

    if (screenshots is List && screenshots.isNotEmpty) {
      final first = screenshots.first;
      if (first is Map<String, dynamic>) {
        cover = first['image']?.toString() ?? thumbnail;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Tujuan8.routeName,
            arguments: ScreenArguments(
              cover,
              data['title']?.toString() ?? 'Game',
              data['description']?.toString() ?? 'Deskripsi tidak tersedia.',
              data['short_description']?.toString() ??
                  'Deskripsi singkat tidak tersedia.',
            ),
          );
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (thumbnail.isNotEmpty)
                  Image.network(
                    thumbnail,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                      height: 180,
                      child: Icon(Icons.videogame_asset, size: 60),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  data['title']?.toString() ?? 'Game',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Genre: ${data['genre'] ?? '-'}'),
                Text('Platform: ${data['platform'] ?? '-'}'),
                Text('Publisher: ${data['publisher'] ?? '-'}'),
                Text('Release Date: ${data['release_date'] ?? '-'}'),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Ketuk kartu untuk melihat detail',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}