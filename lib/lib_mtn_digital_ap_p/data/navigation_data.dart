// data/navigation_data.dart
import '../models/navigation_item.dart';

final List<NavigationItem> navigationItems = [
  const NavigationItem(id: "0", title: "Home", url: "/"),
  const NavigationItem(
      id: "4", title: "Services", url: "/services", showInProject: false),
  const NavigationItem(
      id: "6", title: "Gallery", url: "/gallery", showInProject: false),
  const NavigationItem(id: "12", title: "Your Account", url: "/user-dashboard"),
  const NavigationItem(id: "13", title: "Contact Us", url: "/contact"),
  const NavigationItem(id: "7", title: "About Us", url: "/about", isMisc: true),
  const NavigationItem(
      id: "10",
      title: "Case Studies",
      url: "/case_studies",
      isMisc: true,
      showInProject: false),
  const NavigationItem(
      id: "11",
      title: "Blog",
      url: "/blog",
      isMisc: true,
      showInProject: false),
  const NavigationItem(
    id: "8",
    title: "New account",
    url: "/signup",
    // onlyMobile: true,
    isMisc: true,
    isLogoutTrigger: true, // ✅ Will trigger logout
    showInProject: true, // Add this explicitly
  ),
  const NavigationItem(
    id: "8",
    title: "Sign Out",
    url: "/signout",
    // onlyMobile: true,
    isMisc: true,
    isLogoutTrigger: true, // ✅ Will trigger logout
    showInProject: true, // Add this explicitly
  ),
  const NavigationItem(
      id: "9",
      title: "Sign in",
      url: "#login",
      onlyMobile: true,
      showInProject: false),
  const NavigationItem(
    id: "14",
    title: "Freq Asked Quiz",
    url: "/terms",
    // isMisc: true
  ), // Added new item
];
