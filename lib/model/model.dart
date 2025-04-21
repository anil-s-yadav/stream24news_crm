import 'package:firebase_auth/firebase_auth.dart';

// -------------------- Data Models --------------------

class AllLiveChannelModel {
  final String id;
  final String name;
  final String url;
  final String logo;
  final String language;
  final String region;
  final int viewCount;

  AllLiveChannelModel({
    required this.id,
    required this.name,
    required this.url,
    required this.logo,
    required this.language,
    required this.region,
    required this.viewCount,
  });

  factory AllLiveChannelModel.fromFirestore(
      String id, Map<String, dynamic> data) {
    return AllLiveChannelModel(
      id: id,
      name: data['name'] ?? '',
      url: data['url'] ?? '',
      logo: data['logo'] ?? '',
      language: data['language'] ?? '',
      region: data['region'] ?? '',
      viewCount: data['viewCount'] ?? 0,
    );
  }
}

class ReportedChannelDisplay {
  final AllLiveChannelModel channel;
  final User user;

  ReportedChannelDisplay({
    required this.channel,
    required this.user,
  });
}

class RequestedChannelData {
  final String channelName;
  final String description;
  final User? user;

  RequestedChannelData({
    required this.channelName,
    required this.description,
    required this.user,
  });
}
