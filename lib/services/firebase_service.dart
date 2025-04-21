import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/model.dart';

// -------------------- Firebase Service --------------------

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  /// Fetch all channels from Firestore
  static Future<List<AllLiveChannelModel>> fetchAllChannels() async {
    final List<AllLiveChannelModel> channels = [];

    final snapshot = await _firestore
        .collection('live_chennels')
        .doc('6Kc57CnXtYzg85cD0FXS')
        .collection('all_channels')
        .get();

    for (var doc in snapshot.docs) {
      channels.add(AllLiveChannelModel.fromFirestore(doc.id, doc.data()));
    }

    return channels;
  }

  /// Fetch reported channels (from collection root)
  static Future<List<Map<String, dynamic>>> getReportedChannelsRaw() async {
    final snapshot = await _firestore
        .collection('live_chennels')
        .doc('6Kc57CnXtYzg85cD0FXS')
        .collection('reported_channels')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Fetch channel by ID
  static Future<AllLiveChannelModel?> getChannelById(String id) async {
    final doc = await _firestore
        .collection('live_chennels')
        .doc('6Kc57CnXtYzg85cD0FXS')
        .collection('all_channels')
        .doc(id)
        .get();

    if (doc.exists) {
      return AllLiveChannelModel.fromFirestore(id, doc.data()!);
    }
    return null;
  }

  /// Optional: fetch Firestore-stored user data by uid
  static Future<Map<String, dynamic>?> getFirestoreUserDataById(
      String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  /// Fetch requested channels (nested collection) with auth user match
  static Future<List<RequestedChannelData>>
      fetchRequestedChannelDetails() async {
    final List<RequestedChannelData> result = [];

    final snapshot = await _firestore
        .collection('live_chennels')
        .doc('6Kc57CnXtYzg85cD0FXS')
        .collection('requested_channels')
        .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final String channelName = data['channel_name'] ?? '';
      final String desc = data['desc'] ?? '';
      final String uid = data['uid'] ?? '';

      // Check if this UID matches currently logged in user
      final currentUser = _auth.currentUser;
      User? user;

      if (currentUser != null && currentUser.uid == uid) {
        user = currentUser;
      }

      result.add(RequestedChannelData(
        channelName: channelName,
        description: desc,
        user: user,
      ));
    }

    return result;
  }

  /// Fetch reported channels with current logged in user
  static Future<List<ReportedChannelDisplay>> fetchReportedChannels() async {
    final rawReports = await getReportedChannelsRaw();
    List<ReportedChannelDisplay> detailedList = [];

    final user = currentUser;
    if (user == null) return detailedList;

    for (final report in rawReports) {
      final channelId = report['channel_id'];
      if (channelId == null) continue;

      final channel = await getChannelById(channelId);
      if (channel != null) {
        detailedList.add(ReportedChannelDisplay(channel: channel, user: user));
      }
    }

    return detailedList;
  }
}
