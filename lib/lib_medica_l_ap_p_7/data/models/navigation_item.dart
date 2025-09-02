// models/navigation_item.dart
class NavigationItem {
  final String id;
  final String title;
  final String url;
  final bool onlyMobile;
  final bool isMisc;
  final bool showInProject; // ✅ NEW
  final bool isLogoutTrigger; // ✅

  const NavigationItem({
    required this.id,
    required this.title,
    required this.url,
    this.onlyMobile = false,
    this.isMisc = false,
    this.showInProject = true, // ✅ default is true
    this.isLogoutTrigger = false, // ✅ default: false
  });
}
