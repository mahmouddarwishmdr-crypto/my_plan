import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.boxShadow = const [
      BoxShadow(color: Color(0x0D0D1020), blurRadius: 18, offset: Offset(0, 6)),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}

class AppNetworkImage extends StatelessWidget {
  final String url;
  final IconData fallback;
  final double width;
  final double height;
  final double radius;
  final BoxFit fit;

  const AppNetworkImage({
    super.key,
    required this.url,
    required this.fallback,
    required this.width,
    required this.height,
    this.radius = 10,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final cacheWidth = width.isFinite
        ? (width * MediaQuery.devicePixelRatioOf(context)).round()
        : null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) return child;
          return const ColoredBox(
            color: Color(0xFFF1F2F6),
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: const Color(0xFFF1F2F6),
          child: Icon(fallback, color: const Color(0xFF77819A)),
        ),
      ),
    );
  }
}

class AppSectionHeader extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback? onAction;

  const AppSectionHeader({
    super.key,
    required this.title,
    required this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final actionText = Text(
      action,
      style: const TextStyle(
        color: Color(0xFF5B35F5),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF17203A),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        onAction == null
            ? actionText
            : GestureDetector(onTap: onAction, child: actionText),
      ],
    );
  }
}
