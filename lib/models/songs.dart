class Songs {
  final String title;
  final String artist;
  final String genre;
  final String albumArtUrl;
  final String audioUrl;

  Songs({
    required this.title,
    required this.artist,
    required this.genre,
    required this.albumArtUrl,
    required this.audioUrl,
  });
}

Map<String, String> musicGenre = {
  'Acoustic': 'acoustic',
  'Blues': 'blues',
  'Hip-Hop': 'hiphop',
  'Jazz': 'jazz',
  'Lo-fi': 'lofi',
  'Pop': 'pop',
  'R&B': 'rb',
  'Rock': 'rock',
};
