import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            child: _getContentByType(),
          ),
        ],
      ),
    );
  }

  Widget _getContentByType() {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                log('${channel.logo}');
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF111C44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.network(
                          channel.logo.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image,
                                color: Colors.white54);
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        channel.name,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${channel.language} - ${channel.region}',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (getCountryFlag(channel.region) != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Image.network(
                                getCountryFlag(channel.region)!,
                                width: 16,
                                height: 12,
                              ),
                            ),
                          Text(
                            '${getLanguageName(channel.language)} - ${getCountryName(channel.region)}',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${channel.viewCount} views',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: reported.length,
              itemBuilder: (context, index) {
                final data = reported[index];
                final channel = data.channel;

                return InkWell(
                  onTap: () {
                    onReportedChannelTap?.call(
                      data.user.displayName ?? 'Unknown',
                      data.user.photoURL ?? '',
                      channel.name,
                      'Reported by user',
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF111C44),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Image.network(
                                      channel.logo,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image,
                                            color: Colors.white54);
                                      },
                                    )),
                                const SizedBox(height: 8),
                                Text(
                                  channel.name,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${channel.language} - ${channel.region}',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (getCountryFlag(channel.region) != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Image.network(
                                          getCountryFlag(channel.region)!,
                                          width: 16,
                                          height: 12,
                                        ),
                                      ),
                                    Text(
                                      '${getLanguageName(channel.language)} - ${getCountryName(channel.region)}',
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${channel.viewCount} views',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
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
                    ),
                  ),
                );
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

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3.5,
              ),
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final item = channels[index];
                final userName = item.user?.displayName ?? 'Unknown';

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          child: Text(
                            userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'channel name - ${item.channelName}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Desc - ${item.description}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
    }
  }
}
