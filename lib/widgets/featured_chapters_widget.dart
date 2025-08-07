import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/widgets/section_header.dart';

class FeaturedChaptersWidget extends StatelessWidget {
  final List<String> episodes;

  const FeaturedChaptersWidget({
    required this.episodes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'FEATURED CHAPTERS'),
        const SizedBox(height: 16),
        ...episodes.take(5).map((episode) => _buildChapterItem(episode)),
      ],
    );
  }

  Widget _buildChapterItem(String episodeUrl) {
    // Extrair informações do episódio da URL
    final episodeInfo = _extractEpisodeInfo(episodeUrl);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            episodeInfo['code'] ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              episodeInfo['name'] ?? 'Unknown Episode',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            episodeInfo['date'] ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _extractEpisodeInfo(String episodeUrl) {
    // Exemplo de URL: https://rickandmortyapi.com/api/episode/1
    final parts = episodeUrl.split('/');
    final episodeNumber = parts.last;

    // Simular informações do episódio baseado no número
    final episodeNames = {
      '1': 'Pilot',
      '2': 'Lawnmower Dog',
      '3': 'Anatomy Park',
      '4': 'M. Night Shaym-Aliens!',
      '5': 'Meeseeks and Destroy',
    };

    final episodeDates = {
      '1': 'December 2, 2013',
      '2': 'December 9, 2013',
      '3': 'December 16, 2013',
      '4': 'January 13, 2014',
      '5': 'January 20, 2014',
    };

    return {
      'code': 'S01E$episodeNumber',
      'name': episodeNames[episodeNumber] ?? 'Episode $episodeNumber',
      'date': episodeDates[episodeNumber] ?? 'Unknown Date',
    };
  }
}
