import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/widgets/gender_indicator.dart';
import 'package:ricky_and_martie_app/widgets/status_indicator.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  static const double imageSize = 80.0;

  const CharacterCard({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: const Color(0xFFF5F5DC), // Cor bege clara como na imagem
      child: InkWell(
        onTap: () {
          context.go('/details/${character.id}');
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Imagem do personagem à esquerda
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: imageSize,
                  height: imageSize,
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
                  errorWidget: (context, url, error) {
                    return Container(
                      width: imageSize,
                      height: imageSize,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Informações do personagem à direita
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    //species
                    Text(
                      character.species.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // life status and gender
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Status com ponto verde
                        StatusIndicator(status: character.status),
                        // Gênero com símbolo
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: GenderIndicator(gender: character.gender),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
