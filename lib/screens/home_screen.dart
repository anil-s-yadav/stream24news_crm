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
  String? _selectedPhotoUrl;
  String? _selectedDescription;

  final List<String> _sections = [
    'All channels',
    'Reported channels',
    'Requested channels',
    'News'
  ];

  void _handleReportedChannelTap(String userName, String photoUrl,
      String channelName, String description) {
    setState(() {
      _showEditForm = true;
      _selectedUserName = userName;
      _selectedChannelName = channelName;
      _selectedPhotoUrl = photoUrl;
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
        photoUrl: _selectedPhotoUrl!,
        channelName: _selectedChannelName!,
        description: _selectedDescription!,
        onClose: _handleEditFormClose,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      drawer: isMobile
          ? Drawer(
              child: Sidebar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                    Navigator.of(context).pop(); // Close drawer
                    _showEditForm = false;
                    _selectedUserName = null;
                    _selectedChannelName = null;
                    _selectedDescription = null;
                  });
                },
                sections: _sections,
              ),
            )
          : null,
      appBar: isMobile
          ? AppBar(
              title: Text(_sections[_selectedIndex]),
              backgroundColor: const Color(0xFF0B1437),
              actions: [
                if (_selectedIndex == 0)
                  IconButton(
                    icon: Icon(
                      _showEditForm ? Icons.close : Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _showEditForm = !_showEditForm;
                      });
                    },
                  ),
              ],
            )
          : null,
      body: Container(
        color: const Color(0xFF0B1437),
        child: isMobile
            ? Column(
                children: [
                  if (_selectedIndex == 0 && _showEditForm)
                    const AddChannelForm(),
                  Expanded(child: _getContent()),
                  if (_selectedIndex == 1 &&
                      _showEditForm &&
                      _selectedUserName != null)
                    SizedBox(
                      height: 300,
                      child: _getSideContent(),
                    ),
                ],
              )
            : Row(
                children: [
                  Sidebar(
                    selectedIndex: _selectedIndex,
                    onItemSelected: (index) {
                      setState(() {
                        _selectedIndex = index;
                        _showEditForm = false;
                        _selectedUserName = null;
                        _selectedChannelName = null;
                        _selectedDescription = null;
                      });
                    },
                    sections: _sections,
                  ),
                  Expanded(child: _getContent()),
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
