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
  // Sample data for all channels
  static List<Channel> getAllChannels() {
    return [
      Channel(name: 'News 24', language: 'English'),
      Channel(name: 'Aaj Tak', language: 'Hindi'),
      Channel(name: 'NDTV', language: 'English'),
      Channel(name: 'BBC World', language: 'English'),
      Channel(name: 'CNN', language: 'English'),
      Channel(name: 'Al Jazeera', language: 'English'),
      Channel(name: 'Zee News', language: 'Hindi'),
      Channel(name: 'India Today', language: 'English'),
    ];
  }

  // Sample data for reported channels
  static List<Channel> getReportedChannels() {
    return [
      Channel(
        name: 'Fake News 24',
        language: 'English',
        reportedBy: 'John Doe',
        reportReason: 'Spreading misinformation',
      ),
      Channel(
        name: 'Clickbait News',
        language: 'Hindi',
        reportedBy: 'Jane Smith',
        reportReason: 'Misleading content',
      ),
      Channel(
        name: 'Spam News',
        language: 'English',
        reportedBy: 'Mike Johnson',
        reportReason: 'Excessive advertisements',
      ),
    ];
  }

  // Sample data for requested channels
  static List<Channel> getRequestedChannels() {
    return [
      Channel(
        name: 'Local News 24',
        language: 'English',
        requestedBy: 'Community Group',
        description: 'Local news coverage needed',
      ),
      Channel(
        name: 'Tech News Daily',
        language: 'English',
        requestedBy: 'Tech Association',
        description: 'Technology focused news channel',
      ),
      Channel(
        name: 'Sports Central',
        language: 'Hindi',
        requestedBy: 'Sports Federation',
        description: '24/7 sports coverage',
      ),
    ];
  }

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
