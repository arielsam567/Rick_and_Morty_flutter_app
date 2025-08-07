import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:shimmer/shimmer.dart';

class CharacterImageWidget extends StatelessWidget {
  final Character character;
  final double size;

  const CharacterImageWidget({
    required this.character,
    this.size = 180.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 20,
      child: Stack(
        alignment: Alignment.center,
        children: [  
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: character.getStatusColor(),
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
                      width: size,
                      height: size,
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
                color: character.getStatusColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                character.status.name.toUpperCase(),
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
