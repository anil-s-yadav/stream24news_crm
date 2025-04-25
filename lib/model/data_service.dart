class Channel {
  final String name;
  final String language;
  final String? reportedBy;
  final String? reportReason;
  final String? requestedBy;
  final String? description;

  Channel({
    required this.name,
    required this.language,
    this.reportedBy,
    this.reportReason,
    this.requestedBy,
    this.description,
  });
}

class News {
  final String title;
  final String channelName;
  final String category;
  final DateTime publishedAt;
  final String description;

  News({
    required this.title,
    required this.channelName,
    required this.category,
    required this.publishedAt,
    required this.description,
  });
}

class DataService {
  // Sample data for news
  static List<News> getNews() {
    return [
      News(
        title: 'Breaking: Major Tech Announcement',
        channelName: 'Tech News Daily',
        category: 'Technology',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
        description:
            'A major tech company announces groundbreaking innovation in AI technology.',
      ),
      News(
        title: 'Sports Update: Championship Finals',
        channelName: 'Sports Central',
        category: 'Sports',
        publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
        description:
            'The championship finals are set to begin next week with top teams competing.',
      ),
      News(
        title: 'Local Community Event Success',
        channelName: 'Local News 24',
        category: 'Local',
        publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
        description:
            'The annual community festival draws record attendance this year.',
      ),
      News(
        title: 'Weather Alert: Storm Warning',
        channelName: 'News 24',
        category: 'Weather',
        publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
        description:
            'Severe weather warning issued for coastal areas. Residents advised to take precautions.',
      ),
      News(
        title: 'Business Markets Update',
        channelName: 'NDTV',
        category: 'Business',
        publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
        description:
            'Stock markets show positive trends amid global economic developments.',
      ),
    ];
  }
}
