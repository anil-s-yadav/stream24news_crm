import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _selectedLanguage = 'Hindi';
  String _selectedRegion = 'India';

  @override
  void dispose() {
    _logoUrlController.dispose();
    _channelNameController.dispose();
    _channelUrlController.dispose();
    super.dispose();
  }

  void _onLogoUrlChanged(String url) {
    setState(() => _isValidImageUrl = url.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: _boxDecoration(),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildLogoPreview(),
            const SizedBox(height: 16),
            _buildTextField(_logoUrlController, 'Logo URL', true, (value) {
              if (value == null || value.isEmpty)
                return 'Please enter logo URL';
              return null;
            }, _onLogoUrlChanged),
            const SizedBox(height: 12),
            _buildTextField(_channelNameController, 'Channel Name', false,
                (value) {
              if (value == null || value.isEmpty)
                return 'Please enter a channel name';
              return null;
            }),
            const SizedBox(height: 12),
            _buildTextField(_channelUrlController, 'Channel URL (.m3u8)', false,
                (value) {
              if (value == null || value.isEmpty)
                return 'Please enter a channel URL';
              if (!value.endsWith('.m3u8')) return 'URL must end with .m3u8';
              return null;
            }),
            const SizedBox(height: 12),
            _buildDropdown(
                'Language', _selectedLanguage, languages.keys.toList(),
                (value) {
              if (value != null) setState(() => _selectedLanguage = value);
            }),
            const SizedBox(height: 12),
            _buildDropdown('Region', _selectedRegion,
                countries.map((e) => e['name']!).toList(), (value) {
              if (value != null) setState(() => _selectedRegion = value);
            }),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Text(
        'Add Channel',
        style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      );

  Widget _buildLogoPreview() => Container(
        height: 100,
        decoration: _boxDecoration(),
        child: Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5DD3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _logoUrlController.text.isNotEmpty && _isValidImageUrl
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      (_logoUrlController.text),
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white54),
                                ),
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(Icons.image_not_supported,
                            color: Colors.white54, size: 32),
                      ),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.photo, color: Colors.white54, size: 32),
                  ),
          ),
        ),
      );

  Widget _buildTextField(TextEditingController controller, String label,
          bool isLogoUrl, String? Function(String?) validator,
          [void Function(String)? onChanged]) =>
      TextFormField(
        controller: controller,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
        decoration: _getInputDecoration(label, isLogoUrl: isLogoUrl),
        validator: validator,
        onChanged: onChanged,
      );

  Widget _buildDropdown(String label, String value, List<String> items,
          void Function(String?) onChanged) =>
      Container(
        decoration: _boxDecoration(),
        child: DropdownButtonFormField<String>(
          value: value,
          dropdownColor: const Color(0xFF192555),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
          decoration: _getInputDecoration(label),
          items: items
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 13))))
              .toList(),
          onChanged: onChanged,
        ),
      );

  Widget _buildSubmitButton() => SizedBox(
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FirebaseService().addChannel(AllLiveChannelModel(
                name: _channelNameController.text,
                url: _channelUrlController.text,
                logo: _logoUrlController.text,
                language: languages[_selectedLanguage]!,
                region: countries
                    .firstWhere((e) => e['name'] == _selectedRegion)['code']!,
                viewCount: 0,
                viewedAt: Timestamp.now(),
              ));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C5DD3),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.zero,
          ),
          child: Text('Add Channel',
              style:
                  GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      );

  InputDecoration _getInputDecoration(String label, {bool isLogoUrl = false}) =>
      InputDecoration(
        suffixIcon: isLogoUrl && _logoUrlController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _logoUrlController.clear();
                  setState(() => _isValidImageUrl = false);
                },
              )
            : null,
        labelText: label,
        labelStyle: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.7), fontSize: 12),
        filled: true,
        fillColor: const Color(0xFF192555),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6C5DD3)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );

  BoxDecoration _boxDecoration() => BoxDecoration(
        color: const Color(0xFF192555),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      );
}
