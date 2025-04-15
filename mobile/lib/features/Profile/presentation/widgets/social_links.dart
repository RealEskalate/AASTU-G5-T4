import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinksCard extends StatelessWidget {
  final List<SocialLink> links;

  const SocialLinksCard({
    Key? key,
    required this.links,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Links header
              const Text(
                'Links',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Social links list
              ...links.map((link) => _buildLinkItem(link)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkItem(SocialLink link) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Platform icon with appropriate color
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: link.iconBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: link.iconWidget,
            ),
          ),
          const SizedBox(width: 12),

          // Platform name and URL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  link.platform,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  link.url,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
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

// Model class for social link data
class SocialLink {
  final String platform;
  final String url;
  final Widget iconWidget;
  final Color iconBgColor;

  const SocialLink({
    required this.platform,
    required this.url,
    required this.iconWidget,
    required this.iconBgColor,
  });
}

// Example usage
class SocialLinksExample extends StatelessWidget {
  const SocialLinksExample({Key? key}) : super(key: key);

  // Sample data
  List<SocialLink> getSampleLinks() {
    return [
      SocialLink(
        platform: 'LinkedIn',
        url: 'https://www.linkedin.com/in/...',
        iconWidget: const Icon(FontAwesomeIcons.linkedin,
            color: Colors.white, size: 18),
        iconBgColor: const Color(0xFF0077B5), // LinkedIn blue
      ),
      SocialLink(
        platform: 'Telegram',
        url: 'https://t.me/wondenaty',
        iconWidget: const Icon(FontAwesomeIcons.telegram,
            color: Colors.white, size: 18),
        iconBgColor: const Color(0xFF0088CC), // Telegram blue
      ),
      SocialLink(
        platform: 'Instagram',
        url: 'https://instagram.com/naty...',
        iconWidget: const Icon(FontAwesomeIcons.instagram,
            color: Colors.white, size: 18),
        iconBgColor: const Color(0xFFE1306C), // Instagram pink
      ),
      SocialLink(
        platform: 'Leetcode',
        url: 'https://leetcode.com/ninatin...',
        iconWidget:
            const Icon(FontAwesomeIcons.code, color: Colors.white, size: 18),
        iconBgColor: const Color(0xFFFFA116), // LeetCode orange
      ),
      SocialLink(
        platform: 'Codeforces',
        url: 'https://codeforces.com/pr...',
        iconWidget: const Icon(FontAwesomeIcons.chartBar,
            color: Colors.white, size: 18),
        iconBgColor: const Color(0xFF1F8ACB), // Codeforces blue
      ),
      SocialLink(
        platform: 'Hackerrank',
        url: 'https://www.hackerrank.c...',
        iconWidget: const Icon(FontAwesomeIcons.hackerrank,
            color: Colors.white, size: 18),
        iconBgColor: const Color(0xFF2EC866), // HackerRank green
      ),
      SocialLink(
        platform: 'Github',
        url: 'https://github.com/nina17arse',
        iconWidget:
            const Icon(FontAwesomeIcons.github, color: Colors.white, size: 18),
        iconBgColor: const Color(0xFF333333), // GitHub dark gray
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SocialLinksCard(links: getSampleLinks()),
    );
  }
}
