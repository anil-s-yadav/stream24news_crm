import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream24news_crm/screens/video_play_screen.dart';
import '../model/list_data/country_data.dart';
import '../model/list_data/language_data.dart';
import '../services/firebase_service.dart';
import '../model/model.dart';

enum ChannelListType { all, reported, requested }

class ChannelList extends StatelessWidget {
  final ChannelListType type;
  final Function(String userName, String photoUrl, String channelName,
      String description)? onReportedChannelTap;

  const ChannelList({
    super.key,
    required this.type,
    this.onReportedChannelTap,
  });

  String get _title {
    switch (type) {
      case ChannelListType.all:
        return 'All Channels';
      case ChannelListType.reported:
        return 'Reported Channels';
      case ChannelListType.requested:
        return 'Requested Channels';
    }
  }

  String getLanguageName(String code) {
    final Map<String, String> languages2 = {
      for (var entry in languages.entries) entry.value: entry.key
    };
    return languages2[code.toLowerCase()] ?? code;
  }

  String getCountryName(String code) {
    return countries.firstWhere(
      (country) => country["code"]!.toLowerCase() == code.toLowerCase(),
      orElse: () => {"name": code},
    )["name"]!;
  }

  String? getCountryFlag(String code) {
    return countries.firstWhere(
      (country) => country["code"]!.toLowerCase() == code.toLowerCase(),
      orElse: () => {},
    )["flag"];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF0B1437),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _getContentByType(constraints.maxWidth),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getContentByType(double width) {
    switch (type) {
      case ChannelListType.all:
        return FutureBuilder<List<AllLiveChannelModel>>(
          future: FirebaseService.fetchAllChannels(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final channels = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 280,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                return _buildChannelCard(channel);
              },
            );
          },
        );

      case ChannelListType.reported:
        return FutureBuilder<List<ReportedChannelDisplay>>(
          future: FirebaseService.fetchReportedChannels(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final reported = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1.1,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: reported.length,
              itemBuilder: (context, index) {
                final data = reported[index];
                return _buildReportedChannelCard(data);
              },
            );
          },
        );

      case ChannelListType.requested:
        return FutureBuilder<List<RequestedChannelData>>(
          future: FirebaseService.fetchRequestedChannelDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final channels = snapshot.data ?? [];

            return LayoutBuilder(
              builder: (context, constraints) {
                // double width = constraints.maxWidth;

                // if (width < 820) {
                //  Use ListView on narrow screens
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: channels.length,
                  itemBuilder: (context, index) {
                    return _buildRequestedChannelCard(context, channels[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                );
                // } else {
                //   //  Use GridView for larger screens
                //   return GridView.builder(
                //     padding: const EdgeInsets.all(16),
                //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //       maxCrossAxisExtent: 500,
                //       crossAxisSpacing: 16,
                //       mainAxisSpacing: 16,
                //       childAspectRatio: width > 710 ? 3.5 : 3.0,
                //     ),
                //     itemCount: channels.length,
                //     itemBuilder: (context, index) {
                //       return _buildRequestedChannelCard(
                //           context, channels[index]);
                //     },
                //   );
                // }
              },
            );
          },
        );
    }
  }

  Widget _buildChannelCard(AllLiveChannelModel channel,
      {bool isReported = false, ReportedChannelDisplay? data}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 220;

        return Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPlayScreen(url: channel.url)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF111C44),
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        channel.logo,
                        width: isWide ? 64 : 48,
                        height: isWide ? 64 : 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.broken_image,
                            color: Colors.white54),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Flexible(
                        child: Text(
                          channel.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: isWide ? 14 : 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0025),
                      Text(
                        '${channel.language} - ${channel.region}',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: isWide ? 12 : 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (getCountryFlag(channel.region) != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Image.network(
                                getCountryFlag(channel.region)!,
                                width: isWide ? 18 : 14,
                                height: isWide ? 14 : 10,
                              ),
                            ),
                          Flexible(
                            child: Text(
                              '${getLanguageName(channel.language)} - ${getCountryName(channel.region)}',
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: isWide ? 12 : 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0025),
                      Text(
                        '${channel.viewCount} views',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: isWide ? 12 : 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isReported)
                        ElevatedButton(
                            onPressed: () {
                              onReportedChannelTap?.call(
                                data?.user. ?? 'Unknown',
                                data?.user.photoURL ?? '',
                                data?.channel.name ?? '',
                                'Reported by user',
                              );
                            },
                            child: Text("Edit")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportedChannelCard(ReportedChannelDisplay data) {
    final reportedChannelData = data.channel;
    return Stack(
      children: [
        _buildChannelCard(reportedChannelData, isReported: true, data: data),
        Positioned(
          top: 6,
          right: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red[400]!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Reported',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.red[400],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestedChannelCard(
      BuildContext context, RequestedChannelData item) {
    final userName = item.user?.displayName ?? 'Unknown';
    final channelName = item.channelName;
    final description = item.description;
    log(item.user?.photoURL ?? '');
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.15),
            child: Image.network(
              item.user?.photoURL ?? '',
              width: 24,
              height: 24,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, color: Colors.white54),
            ),
            // Text(
            //   userName[0].toUpperCase(),
            //   style: TextStyle(
            //     color: Theme.of(context).colorScheme.primary,
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Channel: $channelName',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
