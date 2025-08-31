// widgets/hoverable_menu_button.dart
import 'package:broka/lib_medica_l_ap_p/data/models/navigation_item.dart';
import 'package:flutter/material.dart';
// import '../models/navigation_item.dart';

class HoverableMenuButton extends StatefulWidget {
  final List<NavigationItem> items;
  final String currentRoute;
  final void Function(String url) onSelected;

  const HoverableMenuButton({
    super.key,
    required this.items,
    required this.currentRoute,
    required this.onSelected,
  });

  @override
  State<HoverableMenuButton> createState() => _HoverableMenuButtonState();
}

class _HoverableMenuButtonState extends State<HoverableMenuButton> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height),
          child: MouseRegion(
            onExit: (_) => _hideOverlay(),
            child: Material(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.map((item) {
                  final isActive = widget.currentRoute == item.url;
                  return ListTile(
                    dense: true,
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive ? Colors.blue : null,
                      ),
                    ),
                    onTap: () {
                      _hideOverlay();
                      widget.onSelected(item.url);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => _showOverlay(),
        onExit: (_) {
          // Optional: add a delay or require exit from dropdown
        },
        child: TextButton(
          onPressed: () {}, // No tap needed
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: Row(
            children: const [
              Text("More", style: TextStyle(fontWeight: FontWeight.w600)),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
