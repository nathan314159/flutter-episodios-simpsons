

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/episode_model.dart';

class EpisodeView extends StatefulWidget {
  const EpisodeView({super.key});

  @override
  State<EpisodeView> createState() => _EpisodeViewState();
}

class _EpisodeViewState extends State<EpisodeView> {
  EpisodeModel? episode;
  bool loading = true;
  final int episodeId = 1;

  Future<void> fetchEpisode(int id) async {
    try {
      var url = Uri.https('thesimpsonsapi.com', '/api/episodes/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = episodeModelFromJson(response.body);
        if (!mounted) return; 
        setState(() {
          episode = data;
          loading = false;
        });
      } else {
        throw Exception('Error al cargar el episodio');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEpisode(episodeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodio de Simpsons'),
        centerTitle: true,
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : episode == null
                ? const Text('No se pudo cargar el episodio')
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdn.thesimpsonsapi.com/500${episode!.imagePath}',
                          height: 220,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nombre: ${episode!.name}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Temporada: ${episode!.season}, Episodio: ${episode!.episodeNumber}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          episode!.synopsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Fecha de emisión: ${episode!.airdate}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
