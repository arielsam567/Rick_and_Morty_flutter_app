import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/widgets/properties_widget.dart';
import 'package:ricky_and_martie_app/widgets/whereabouts_widget.dart';
import 'package:ricky_and_martie_app/widgets/featured_chapters_widget.dart';
import 'package:ricky_and_martie_app/widgets/character_image_widget.dart';
import 'package:ricky_and_martie_app/widgets/error_message_widget.dart';
import 'package:ricky_and_martie_app/widgets/details_page_shimmer.dart';
import 'package:ricky_and_martie_app/pages/details/details_controller.dart';

class DetailsPage extends StatefulWidget {
  final int characterId;

  const DetailsPage({
    required this.characterId,
    super.key,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    // Carrega os dados do personagem quando a página é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailsController>().loadCharacter(widget.characterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DetailsController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const DetailsPageShimmer();
            }

            if (controller.error != null) {
              return ErrorMessageWidget(
                icon: Icons.error_outline,
                title: 'Erro ao carregar personagem',
                message: controller.error,
                onRetry: () => controller.loadCharacter(widget.characterId),
              );
            }

            final character = controller.character;
            if (character == null) {
              return const Center(
                child: Text('Personagem não encontrado'),
              );
            }

            return SingleChildScrollView(
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
            );
          },
        ),
      ),
    );
  }
}
