import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_omni/controller/music_controller.dart';
import 'package:zenith_omni/routing/app_routes.dart';
import '../../reusable_widgets/genre_card.dart';

class SelectGenre extends StatefulWidget {
  const SelectGenre({super.key});

  @override
  State<SelectGenre> createState() => _SelectGenreState();
}

class _SelectGenreState extends State<SelectGenre> {
  final MusicController musicController = MusicController();
  bool isLoading = false;

  final List<Map<String, dynamic>> genres = [
    {
      'title': 'Pop',
      'tracks': '30',
      'icon': 'assets/genre_icons/pop.svg',
      'color': Colors.deepPurpleAccent,
    },
    {
      'title': 'Rock',
      'tracks': '30',
      'icon': 'assets/genre_icons/rock.svg',
      'color': Colors.redAccent.shade700,
    },
    {
      'title': 'Hip-Hop',
      'tracks': '30',
      'icon': 'assets/genre_icons/hiphop.svg',
      'color': Colors.indigo.shade600,
    },
    {
      'title': 'Jazz',
      'tracks': '30',
      'icon': 'assets/genre_icons/jazz.svg',
      'color': Colors.amber.shade900,
    },
    {
      'title': 'Lo-Fi',
      'tracks': '30',
      'icon': 'assets/genre_icons/lofi.svg',
      'color': Colors.teal.shade700,
    },
    {
      'title': 'Blues',
      'tracks': '30',
      'icon': 'assets/genre_icons/blues.svg',
      'color': Colors.blue.shade900,
    },
    {
      'title': 'Acoustic',
      'tracks': '30',
      'icon': 'assets/genre_icons/acoustic.svg',
      'color': Colors.orange.shade800,
    },
    {
      'title': 'R&B',
      'tracks': '30',
      'icon': 'assets/genre_icons/rnb.svg',
      'color': Colors.pinkAccent.shade700,
    },
  ];

  Future<void> handleGenreTap(String genreTitle) async {
    try {
      setState(() => isLoading = true);

      // Fetch songs for this genre
      await musicController.getSongsData(genreTitle);

      if (musicController.playlist.isNotEmpty) {
        // Shuffle for random play
        musicController.playlist.shuffle();

        if (mounted) {
          context.pushNamed(
            AppRoutes.musicPlayer.name,
            extra: {'playlist': musicController.playlist, 'initialIndex': 0},
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No music found. Check your internet!"),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Error loading genre: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Hero(
                          tag: 'sound_studio',
                          child: SvgPicture.asset(
                            'assets/app_icons/icon_sound_studio.svg',
                            height: 50,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Sound Studio',
                          style: GoogleFonts.poppins(
                            textStyle: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "What's your mood?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.1,
                          ),
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        return GenreCard(
                          title: genre['title'],
                          tracks: genre['tracks'],
                          iconPath: genre['icon'],
                          color: genre['color'],
                          onTap: () => handleGenreTap(genre['title']),
                        );
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
