import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String _selectedLanguage = 'Hindi';

  final List<String> _languages = ['Hindi', 'English', 'Tamil', 'Telugu'];

  @override
  void dispose() {
    _logoUrlController.dispose();
    _channelNameController.dispose();
    _channelUrlController.dispose();
    super.dispose();
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5DD3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 20,
                        color: const Color(0xFF6C5DD3),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add Logo',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
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
              decoration: _getInputDecoration('Logo URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a logo URL';
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
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: _languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(
                      language,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                      ),
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
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement add channel functionality
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

  InputDecoration _getInputDecoration(String label) {
    return InputDecoration(
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
