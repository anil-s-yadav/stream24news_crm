import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/news_list.dart';
import '../widgets/channel_list.dart';
import '../widgets/add_channel_form.dart';
import '../widgets/edit_channel_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _showEditForm = false;
  String? _selectedUserName;
  String? _selectedChannelName;
  String? _selectedDescription;

  final List<String> _sections = [
    'All channels',
    'Reported channels',
    'Requested channels',
    'News'
  ];

  void _handleReportedChannelTap(
      String userName, String channelName, String description) {
    setState(() {
      _showEditForm = true;
      _selectedUserName = userName;
      _selectedChannelName = channelName;
      _selectedDescription = description;
    });
  }

  void _handleEditFormClose() {
    setState(() {
      _showEditForm = false;
      _selectedUserName = null;
      _selectedChannelName = null;
      _selectedDescription = null;
    });
  }

  Widget _getContent() {
    switch (_selectedIndex) {
      case 0:
        return const ChannelList(type: ChannelListType.all);
      case 1:
        return ChannelList(
          type: ChannelListType.reported,
          onReportedChannelTap: _handleReportedChannelTap,
        );
      case 2:
        return const ChannelList(type: ChannelListType.requested);
      case 3:
        return const NewsList();
      default:
        return const Center(child: Text('Select a section'));
    }
  }

  Widget? _getSideContent() {
    if (_selectedIndex == 0) {
      return const AddChannelForm();
    }
    if (_selectedIndex == 1 && _showEditForm && _selectedUserName != null) {
      return EditChannelForm(
        userName: _selectedUserName!,
        channelName: _selectedChannelName!,
        description: _selectedDescription!,
        onClose: _handleEditFormClose,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0B1437),
        child: Row(
          children: [
            Sidebar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                  // Reset edit form state when changing sections
                  if (index != 1) {
                    _showEditForm = false;
                    _selectedUserName = null;
                    _selectedChannelName = null;
                    _selectedDescription = null;
                  }
                });
              },
              sections: _sections,
            ),
            Expanded(
              child: _getContent(),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: _getSideContent() ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
