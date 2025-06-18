import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> with TickerProviderStateMixin {
  bool isDarkMode = false;
  String selectedLanguage = 'English';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Hindi', 'code': 'hi'},
    {'name': 'Spanish', 'code': 'es'},
    {'name': 'French', 'code': 'fr'},
    {'name': 'German', 'code': 'de'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          )
              : AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: AppTheme.defaultSpacing, left:AppTheme.defaultSpacing, right: AppTheme.defaultSpacing ),
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF1E1E1E) : AppTheme.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppTheme.cardBorderRadius),
                        topRight: Radius.circular(AppTheme.cardBorderRadius),
                      ),
                    ),
                    child: _buildSettingsContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: AppTheme.white,
              size: 28,
            ),
          ),
          const SizedBox(width: AppTheme.smallSpacing),
          Text(
            'Settings',
            style: AppTheme.FontStyle.copyWith(fontSize: 24),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.settings,
              color: AppTheme.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent() {
    return ListView(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      children: [
        _buildSectionTitle('Appearance'),
        const SizedBox(height: AppTheme.mediumSpacing),
        _buildThemeCard(),
        const SizedBox(height: AppTheme.extraLargeSpacing),
        _buildSectionTitle('Language'),
        const SizedBox(height: AppTheme.mediumSpacing),
        _buildLanguageCard(),
        const SizedBox(height: AppTheme.extraLargeSpacing),
        _buildSectionTitle('About'),
        const SizedBox(height: AppTheme.mediumSpacing),
        _buildAboutCard(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? AppTheme.white : AppTheme.primaryBlue,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget _buildThemeCard() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      color: isDarkMode ? const Color(0xFF2A2A2A) : AppTheme.white,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: AppTheme.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theme Mode',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? AppTheme.white : Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        isDarkMode ? 'Dark Mode' : 'Light Mode',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? AppTheme.white70 : Colors.grey[600],
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: AppTheme.buttonAnimationDuration,
                  child: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                    activeColor: AppTheme.primaryBlue,
                    activeTrackColor: AppTheme.blue200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            Row(
              children: [
                Expanded(
                  child: _buildThemePreview(false, 'Light'),
                ),
                const SizedBox(width: AppTheme.smallSpacing),
                Expanded(
                  child: _buildThemePreview(true, 'Dark'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview(bool isDark, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = isDark;
        });
      },
      child: AnimatedContainer(
        duration: AppTheme.buttonAnimationDuration,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A2E) : AppTheme.blue50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode == isDark ? AppTheme.primaryBlue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                gradient: isDark
                    ? const LinearGradient(colors: [Color(0xFF1A1A2E), Color(0xFF16213E)])
                    : AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppTheme.white : AppTheme.primaryBlue,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      color: isDarkMode ? const Color(0xFF2A2A2A) : AppTheme.white,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.language,
                    color: AppTheme.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? AppTheme.white : Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        selectedLanguage,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? AppTheme.white70 : Colors.grey[600],
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: isDarkMode ? AppTheme.white70 : Colors.grey[600],
                ),
              ],
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            ...languages.map((language) => _buildLanguageOption(language['name']!)),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    bool isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: AnimatedContainer(
        duration: AppTheme.buttonAnimationDuration,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? AppTheme.primaryBlue.withOpacity(0.3) : AppTheme.blue50)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? AppTheme.primaryBlue
                    : (isDarkMode ? AppTheme.white : Colors.black87),
                fontFamily: 'Roboto',
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      color: isDarkMode ? const Color(0xFF2A2A2A) : AppTheme.white,
      child: Column(
        children: [
          _buildAboutItem(Icons.info_outline, 'App Version', '1.0.0'),
          _buildAboutItem(Icons.privacy_tip_outlined, 'Privacy Policy', ''),
          _buildAboutItem(Icons.description_outlined, 'Terms of Service', ''),
          _buildAboutItem(Icons.help_outline, 'Help & Support', ''),
        ],
      ),
    );
  }

  Widget _buildAboutItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.white,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? AppTheme.white : Colors.black87,
          fontFamily: 'Roboto',
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: isDarkMode ? AppTheme.white70 : Colors.grey[600],
          fontFamily: 'Roboto',
        ),
      )
          : null,
      trailing: subtitle.isEmpty
          ? Icon(
        Icons.keyboard_arrow_right,
        color: isDarkMode ? AppTheme.white70 : Colors.grey[600],
      )
          : null,
      onTap: subtitle.isEmpty ? () {} : null,
    );
  }
}
