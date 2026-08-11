import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_omni/controller/music_controller.dart';
import 'package:zenith_omni/models/songs.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({
    super.key,
    required this.playlist,
    required this.initialIndex,
  });

  final List<Songs> playlist;
  final int initialIndex;

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late MusicController controller;
  bool isShuffleOn = false;
  bool isTap = false;

  @override
  void initState() {
    super.initState();
    controller = MusicController();
    controller.playlist = List.from(widget.playlist);
    controller.playSong(widget.initialIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    String minutes = duration.inMinutes.toString();
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Safety check: if playlist is empty, show a loader or error
    if (controller.playlist.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentSong = controller.playlist[controller.currentSongIndex];

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: Text(
          'NOW PLAYING',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // 1. ALBUM ART - Updates instantly on index change
                Container(
                  height: MediaQuery.of(context).size.width - 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: NetworkImage(currentSong.albumArtUrl),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // 2. TRACK INFO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.title,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${currentSong.artist} • ${currentSong.genre}",
                            style: textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isTap = !isTap;
                        });
                      },
                      icon: Icon(
                        isTap ? Icons.favorite : Icons.favorite_border,
                        color: isTap ? Colors.green : Colors.grey,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // 3. PROGRESS SECTION
                StreamBuilder<Duration>(
                  stream: controller.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return StreamBuilder<Duration?>(
                      stream: controller.durationStream,
                      builder: (context, snapshot) {
                        final duration = snapshot.data ?? Duration.zero;
                        return Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                activeTrackColor: Colors.black,
                                inactiveTrackColor: Colors.grey.shade300,
                                thumbColor: Colors.black,
                              ),
                              child: Slider(
                                value: position.inSeconds.toDouble(),
                                max: duration.inSeconds.toDouble() > 0
                                    ? duration.inSeconds.toDouble()
                                    : 1.0,
                                onChanged: (value) {
                                  controller.player.seek(
                                    Duration(seconds: value.toInt()),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDuration(position),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    formatDuration(duration),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),

                // 4. MAIN CONTROLS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.toggleShuffle();
                        setState(() {
                          isShuffleOn = !isShuffleOn;
                          // If shuffle is on, the list order changes, so index 0 is a new song
                        });
                      },
                      icon: Icon(
                        Icons.shuffle_rounded,
                        color: isShuffleOn ? Colors.green : Colors.grey,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.previous();
                        setState(() {}); // Updates the UI to show the new song
                      },
                      icon: const Icon(Icons.skip_previous_rounded, size: 45),
                    ),
                    StreamBuilder<bool>(
                      stream: controller.isPlayingStream,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data ?? false;
                        return CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          child: IconButton(
                            onPressed: () => isPlaying
                                ? controller.pause()
                                : controller.resume(),
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        controller.next();
                        setState(() {}); // Updates the UI to show the new song
                      },
                      icon: const Icon(Icons.skip_next_rounded, size: 45),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          controller.toggleRepeat();
                        });
                      },
                      icon: const Icon(
                        Icons.repeat_rounded,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
