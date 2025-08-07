import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/widgets/properties_widget.dart';
import 'package:ricky_and_martie_app/widgets/whereabouts_widget.dart';
import 'package:ricky_and_martie_app/widgets/featured_chapters_widget.dart';

class DetailsPage extends StatelessWidget {
  final Character character;

  const DetailsPage({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header com botão voltar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go('/'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Imagem do personagem com status
                _buildCharacterImage(),
                const SizedBox(height: 16),

                // Nome do personagem
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Seção Properties
                PropertiesWidget(
                  gender: character.gender,
                  species: character.species,
                  status: character.status,
                ),
                const SizedBox(height: 24),

                // Seção Whereabouts
                WhereaboutsWidget(
                  origin: character.origin,
                  location: character.location,
                ),
                const SizedBox(height: 24),

                // Seção Featured Chapters
                FeaturedChaptersWidget(
                  episodes: character.episode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterImage() {
    final imageSize = 180.0;

    final isDead = character.status.toLowerCase() == 'dead';
    final borderColor = isDead ? Colors.red : Colors.green;

    return SizedBox(
      height: imageSize + 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Imagem do personagem
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // Badge de status
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                character.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
