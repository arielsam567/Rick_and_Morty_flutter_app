import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/widgets/properties_widget.dart';
import 'package:ricky_and_martie_app/widgets/whereabouts_widget.dart';
import 'package:ricky_and_martie_app/widgets/featured_chapters_widget.dart';
import 'package:ricky_and_martie_app/widgets/character_image_widget.dart';

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
                CharacterImageWidget(
                  imageUrl: character.image,
                  status: character.status,
                ),
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
}
