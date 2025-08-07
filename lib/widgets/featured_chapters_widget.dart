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
        ListView.builder(
          itemCount: episodes.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => _buildChapterItem(episodes[index]),
        ),
      ],
    );
  }

  Widget _buildChapterItem(String episodeUrl) {
    final episodeInfo = _extractEpisodeInfo(episodeUrl);

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Text(
              episodeInfo['code'] ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
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
      ),
    );
  }

  Map<String, String> _extractEpisodeInfo(String episodeUrl) {
    final parts = episodeUrl.split('/');
    final episodeNumber = parts.last;
    const epPerSeason = 11;

    final season = (int.parse(episodeNumber) ~/ epPerSeason) + 1;
    final episode = int.parse(episodeNumber) % epPerSeason;

    return {
      'code':
          'S${season.toString().padLeft(2, '0')}E${episode.toString().padLeft(2, '0')}',
      'name': 'Episode $episode',
      'date': 'Unknown Date',
    };
  }
}
