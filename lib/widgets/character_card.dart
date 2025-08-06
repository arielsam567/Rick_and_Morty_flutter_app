import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ricky_and_martie_app/models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  static const double radius = 100.0;
  static const double imageSize = 120.0;

  const CharacterCard({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          // Navegar para a tela de detalhes
          context.go('/details/${character.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radius),
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
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
