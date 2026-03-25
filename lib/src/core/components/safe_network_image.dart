import 'package:flutter/material.dart';

class SafeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final String fallbackAssetPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SafeNetworkImage({
    required this.imageUrl,
    required this.fallbackAssetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    super.key,
  });

  bool get _hasValidNetworkUrl {
    if (imageUrl == null || imageUrl!.trim().isEmpty) return false;
    final uri = Uri.tryParse(imageUrl!);
    if (uri == null) return false;
    if (!(uri.isScheme('http') || uri.isScheme('https'))) return false;
    return uri.host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasValidNetworkUrl) {
      return Image.asset(
        fallbackAssetPath,
        width: width,
        height: height,
        fit: fit,
      );
    }

    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => Image.asset(
        fallbackAssetPath,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
