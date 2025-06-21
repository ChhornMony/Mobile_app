import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Ionicons.settings_outline),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // User Information Section
            _buildUserInfoSection(),
            const SizedBox(height: 24),

            // Account Actions
            _buildAccountActions(),
            const SizedBox(height: 24),

            // App Settings
            _buildAppSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage:
              NetworkImage('https://randomuser.me/api/portraits/women/65.jpg'),
        ),
        const SizedBox(height: 16),
        Text(
          'Chhorn Mony',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'chhornmony10@gmail.com',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Edit profile action
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget _buildUserInfoSection() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(Ionicons.location_outline, 'Address',
                '123 Main St, Phnom Penh Themy, PP'),
            const Divider(height: 24),
            _buildInfoRow(Ionicons.call_outline, 'Phone', '+885 98574219'),
            const Divider(height: 24),
            _buildInfoRow(
                Ionicons.card_outline, 'Payment Methods', 'VISA •••• 4242'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Icon(Ionicons.chevron_forward, size: 20, color: Colors.grey[400]),
      ],
    );
  }

  Widget _buildAccountActions() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildActionTile(Ionicons.bag_outline, 'My Orders', () {}),
          const Divider(height: 1),
          _buildActionTile(Ionicons.heart_outline, 'Wishlist', () {}),
          const Divider(height: 1),
          _buildActionTile(Ionicons.star_outline, 'Reviews', () {}),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildActionTile(
              Ionicons.notifications_outline, 'Notifications', () {}),
          const Divider(height: 1),
          _buildActionTile(Ionicons.shield_checkmark_outline, 'Privacy', () {}),
          const Divider(height: 1),
          _buildActionTile(
              Ionicons.help_circle_outline, 'Help & Support', () {}),
          const Divider(height: 1),
          _buildActionTile(Ionicons.log_out_outline, 'Logout', () {},
              isLogout: true),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? const Color.fromARGB(255, 207, 22, 9) : Colors.grey[800],
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing:
          Icon(Ionicons.chevron_forward, size: 20, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}
