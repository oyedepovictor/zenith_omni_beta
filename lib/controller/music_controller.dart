import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zenith_omni/models/songs.dart';
import 'package:zenith_omni/services/music_networking.dart';
import 'dart:async';
import 'api_config.dart';

enum RepeatMode { off, all, one }

class MusicController {
  final AudioPlayer player = AudioPlayer();
  List<Songs> playlist = [];
  int currentSongIndex = 0;
  bool isShuffleOn = false;
  RepeatMode repeatMode = RepeatMode.off;

  final StreamController<int> indexController =
      StreamController<int>.broadcast();
  Stream<int> get currentIndexStream => indexController.stream;

  int get currentSongsIndex => currentSongIndex;

  MusicController() {
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _handleSongEnd();
      }
    });
  }

  void _handleSongEnd() {
    if (repeatMode == RepeatMode.one) {
      // Replay the same song
      player.seek(Duration.zero);
      player.play();
    } else if (repeatMode == RepeatMode.all) {
      // Always play next (will wrap around)
      next();
    } else if (currentSongIndex < playlist.length - 1) {
      // Repeat Off: only play next if not at the end
      next();
    }
    // Otherwise, stay stopped at the end of the list
  }

  Future<void> getSongsData(String genreName) async {
    final tag = musicGenre[genreName] ?? 'pop';
    final url =
        'https://api.jamendo.com/v3.0/tracks/?client_id=${ApiConfig.jamendoKey}&format=json&limit=20&fuzzytags=$tag';

    NetworkHelper networkHelper = NetworkHelper(url);
    var songsData = await networkHelper.getData();

    if (songsData != null && songsData['results'] != null) {
      List<dynamic> results = songsData['results'];
      playlist = results.map((json) {
        return Songs(
          title: json['name'] ?? 'Unknown',
          artist: json['artist_name'] ?? 'Unknown',
          genre: genreName,
          albumArtUrl: json['image'] ?? '',
          audioUrl: json['audio'] ?? '',
        );
      }).toList();
    }
  }

  Future<void> playSong(int index) async {
    if (playlist.isEmpty) return;
    currentSongIndex = index % playlist.length;
    indexController.add(currentSongIndex);

    try {
      await player.setUrl(playlist[currentSongIndex].audioUrl);
      player.play();
    } catch (e) {
      if (kDebugMode) debugPrint("Playback Error: $e");
    }
  }

  void toggleShuffle() {
    isShuffleOn = !isShuffleOn;
    if (isShuffleOn) {
      playlist.shuffle();
      playSong(0);
    }
  }

  void toggleRepeat() {
    if (repeatMode == RepeatMode.off) {
      repeatMode = RepeatMode.all;
    } else if (repeatMode == RepeatMode.all) {
      repeatMode = RepeatMode.one;
    } else {
      repeatMode = RepeatMode.off;
    }
  }

  void pause() => player.pause();
  void resume() => player.play();
  void next() => playSong(currentSongIndex + 1);
  void previous() => playSong(currentSongIndex - 1 + playlist.length);
  void setVolume(double value) => player.setVolume(value);

  Stream<bool> get isPlayingStream => player.playingStream;
  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration?> get durationStream => player.durationStream;

  void dispose() {
    player.dispose();
    indexController.close();
  }
}
