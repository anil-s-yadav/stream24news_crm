import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// -------------------- Data Models --------------------

class AllLiveChannelModel {
  final String name;
  final String url;
  final String logo;
  final String language;
  final String region;
  final int viewCount;
  final Timestamp viewedAt;

  AllLiveChannelModel({
    required this.name,
    required this.url,
    required this.logo,
    required this.language,
    required this.region,
    required this.viewCount,
    required this.viewedAt,
  });

  factory AllLiveChannelModel.fromFirestore(Map<String, dynamic> data) {
    return AllLiveChannelModel(
      name: data['name'] ?? '',
      url: data['url'] ?? '',
      logo: data['logo'] ?? '',
      language: data['language'] ?? '',
      region: data['region'] ?? '',
      viewCount: data['viewCount'] ?? 0,
      viewedAt: data['viewedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'logo': logo,
      'language': language,
      'region': region,
      'viewCount': viewCount,
      'viewAt': viewCount,
    };
  }
}

class ReportedChannelDisplay {
  final AllLiveChannelModel channel;
  final Map<String, dynamic>? user;

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
