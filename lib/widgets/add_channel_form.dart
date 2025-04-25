import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stream24news_crm/model/list_data/language_data.dart';
import 'package:stream24news_crm/model/model.dart';
import 'package:stream24news_crm/services/firebase_service.dart';

import '../model/list_data/country_data.dart';

class AddChannelForm extends StatefulWidget {
  const AddChannelForm({super.key});

  @override
  State<AddChannelForm> createState() => _AddChannelFormState();
}

class _AddChannelFormState extends State<AddChannelForm> {
  final _formKey = GlobalKey<FormState>();
  final _logoUrlController = TextEditingController();
  final _channelNameController = TextEditingController();
  final _channelUrlController = TextEditingController();
  bool _isValidImageUrl = false;
  String _selectedLanguage = 'Hindi'; // default selected key
  String _selectedRegion = 'India'; // default name

  @override
  void dispose() {
    _logoUrlController.dispose();
    _channelNameController.dispose();
    _channelUrlController.dispose();
    super.dispose();
  }

  Future<bool> _validateImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      final contentType = response.headers['content-type'];
      return contentType != null && contentType.startsWith('image/');
    } catch (e) {
      return false;
    }
  }

  void _onLogoUrlChanged(String url) async {
    if (url.isNotEmpty) {
      final isValid = await _validateImageUrl(url);
      setState(() {
        _isValidImageUrl = isValid;
      });
    } else {
      setState(() {
        _isValidImageUrl = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: const Color(0xFF111C44),
        border: Border(
          left: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Channel',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF192555),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5DD3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          _logoUrlController.text.isNotEmpty && _isValidImageUrl
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    _logoUrlController.text,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white54,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.white54,
                                          size: 32,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.photo,
                                    color: Colors.white54,
                                    size: 32,
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _logoUrlController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
              ),
              decoration: _getInputDecoration('Logo URL', isLogoUrl: true),
              onChanged: _onLogoUrlChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter logo URL';
                }
                if (!_isValidImageUrl) {
                  return 'Please enter a valid image URL';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _channelNameController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
              ),
              decoration: _getInputDecoration('Channel Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a channel name';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _channelUrlController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
              ),
              decoration: _getInputDecoration('Channel URL (.m3u8)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a channel URL';
                }
                if (!value.endsWith('.m3u8')) {
                  return 'URL must end with .m3u8';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF192555),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedLanguage,
                  dropdownColor: const Color(0xFF192555),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Language',
                    labelStyle: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                  items: languages.keys.map((key) {
                    return DropdownMenuItem(
                      value: key,
                      child: Text(
                        key,
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 13),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    }
                  },
                )),
            const SizedBox(height: 12),
            Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF192555),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedRegion,
                  dropdownColor: const Color(0xFF192555),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Region',
                    labelStyle: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                  items: countries.map((country) {
                    return DropdownMenuItem(
                      value: country['name'],
                      child: Text(
                        country['name']!,
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 13),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRegion = value;
                      });
                    }
                  },
                )),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseService().addChannel(AllLiveChannelModel(
                      name: _channelNameController.text,
                      url: _channelUrlController.text,
                      logo: _logoUrlController.text,
                      language: languages[_selectedLanguage]!,
                      region: countries.firstWhere(
                          (e) => e['name'] == _selectedRegion)['code']!,
                      viewCount: 0,
                      viewedAt: Timestamp.now(),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5DD3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Add Channel',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(String label, {bool isLogoUrl = false}) {
    return InputDecoration(
      suffixIcon: isLogoUrl && _logoUrlController.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _logoUrlController.clear();
                setState(() {
                  _isValidImageUrl = false;
                });
              },
            )
          : null,
      labelText: label,
      labelStyle: GoogleFonts.inter(
        color: Colors.white.withOpacity(0.7),
        fontSize: 12,
      ),
      filled: true,
      fillColor: const Color(0xFF192555),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF6C5DD3),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
    );
  }
}
