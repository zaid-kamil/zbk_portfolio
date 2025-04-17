import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateCard extends StatelessWidget {
  final String title;
  final String issuedBy;
  final String imageUrl;
  final String? credentialUrl;
  final void Function()? onTap;

  const CertificateCard({
    super.key,
    required this.title,
    required this.issuedBy,
    required this.imageUrl,
    this.credentialUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallCard = constraints.maxWidth < 200;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // light grey border
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImageSection(),
              _buildContentSection(context, isSmallCard),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: 140, // Smaller height than project card
      width: double.infinity,
      child: Hero(
        transitionOnUserGestures: true,
        tag: 'certificate-image-${title.hashCode}',
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.award,
                        size: 40,
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context, bool isSmallCard) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(context, isSmallCard),
          const SizedBox(height: 4),
          _buildIssuedBy(context, isSmallCard),
          const SizedBox(height: 8),
          if (credentialUrl != null) _buildCredentialButton(isSmallCard),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isSmallCard) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isSmallCard ? 13 : 15,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildIssuedBy(BuildContext context, bool isSmallCard) {
    return Text(
      issuedBy,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: isSmallCard ? 11 : 13,
            color: Theme.of(context).colorScheme.secondary,
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCredentialButton(bool isSmallCard) {
    return SizedBox(
      height: isSmallCard ? 32 : 36,
      child: OutlinedButton.icon(
        onPressed: () => _launchUrl(credentialUrl!),
        icon: Icon(Icons.verified, size: isSmallCard ? 16 : 18),
        label: Text(
          'View Credentials',
          style: TextStyle(fontSize: isSmallCard ? 10 : 12),
        ),
        style: FilledButton.styleFrom(
          padding: EdgeInsets.all(isSmallCard ? 4 : 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
