import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';

void showPopupDialog(
  BuildContext context, {
  String? message,
  bool isError = false,
  VoidCallback? onClose,
  Duration? autoCloseDuration,
  String? buttonText,
  String? navigateTo,
  bool showButton = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      if (autoCloseDuration != null) {
        Future.delayed(autoCloseDuration, () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
            if (navigateTo != null) {
              Navigator.pushNamed(context, navigateTo);
            }
            if (onClose != null) {
              onClose();
            }
          }
        });
      }

      final screenWidth = MediaQuery.of(context).size.width;
      final isWideScreen = screenWidth > 600;

      return WillPopScope(
        onWillPop: () async {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
            if (onClose != null) {
              onClose();
            }
          }
          return false;
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          contentPadding: EdgeInsets.fromLTRB(
            isWideScreen ? 24 : 16,
            16,
            isWideScreen ? 24 : 16,
            16,
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isWideScreen ? 400 : screenWidth * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, size: 24),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        if (onClose != null) {
                          onClose();
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isError ? Icons.error : Icons.check_circle,
                      color: isError ? Colors.red : Colors.green,
                      size: isWideScreen ? 32 : 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SelectableText(
                        message ?? 'Quote saved successfully!',
                        style: TextStyle(
                          fontSize: isWideScreen ? 18 : 16,
                        ),
                        enableInteractiveSelection: true,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          selectAll: true,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isError) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: message ?? ''),
                        );
                        // Optional: Show a snackbar to confirm copy
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Message copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 20),
                      label: const Text('Copy Error'),
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: showButton
              ? [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: NouvaButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        if (!isError && navigateTo != null) {
                          Navigator.pushNamed(context, navigateTo);
                        }
                        if (!isError && onClose != null) {
                          onClose();
                        }
                      },
                      text:
                          buttonText ?? (isError ? 'Close' : 'Go to Dashboard'),
                    ),
                  ),
                ]
              : [],
        ),
      );
    },
  );
}

// // lib/lib_medica_l_ap_p/widgets/ui/dialog_utils.dart
// import 'package:flutter/material.dart';
// import 'package:medica_l_ap_p/lib_medica_l_ap_p/widgets/ui/nouva_ui_components.dart';
// import 'package:flutter/services.dart';

// // Displays a customizable popup dialog with optional auto-close, navigation, and actions.
// void showPopupDialog(
//   BuildContext context, {
//   String? message,
//   bool isError = false,
//   VoidCallback? onClose,
//   Duration? autoCloseDuration,
//   String? buttonText,
//   String? navigateTo,
//   bool showButton = true,
// }) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevents dismissing by tapping outside
//     builder: (BuildContext dialogContext) {
//       // Schedule auto-close if duration is provided
//       if (autoCloseDuration != null) {
//         Future.delayed(autoCloseDuration, () {
//           if (Navigator.of(dialogContext).canPop()) {
//             Navigator.of(dialogContext).pop();
//             if (navigateTo != null) {
//               Navigator.pushNamed(context, navigateTo);
//             }
//             if (onClose != null) {
//               onClose();
//             }
//           }
//         });
//       }

//       return WillPopScope(
//         // Handles Android back button or Escape key on desktop/web
//         onWillPop: () async {
//           if (Navigator.of(dialogContext).canPop()) {
//             Navigator.of(dialogContext).pop();
//             if (onClose != null) {
//               onClose();
//             }
//           }
//           return false; // Prevents default pop behavior
//         },
//         child: AlertDialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(16)),
//           ),
//           contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Close button at top-right
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.close, size: 24),
//                     onPressed: () {
//                       Navigator.of(dialogContext).pop();
//                       if (onClose != null) {
//                         onClose();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//               // Dialog content with icon and message
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     isError ? Icons.error : Icons.check_circle,
//                     color: isError ? Colors.red : Colors.green,
//                     size: 28,
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SelectableText(
//                           message ?? 'Quote saved successfully!',
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 8),
//                         TextButton.icon(
//                           icon: const Icon(Icons.copy, size: 20),
//                           label: const Text('Copy Message'),
//                           onPressed: () {
//                             Clipboard.setData(
//                                 ClipboardData(text: message ?? ''));
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Message copied to clipboard'),
//                                 duration: Duration(seconds: 2),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: showButton
//               ? [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: NouvaButton(
//                       onPressed: () {
//                         Navigator.of(dialogContext).pop();
//                         if (!isError && navigateTo != null) {
//                           Navigator.pushNamed(context, navigateTo);
//                         }
//                         if (!isError && onClose != null) {
//                           onClose();
//                         }
//                       },
//                       text:
//                           buttonText ?? (isError ? 'Close' : 'Go to Dashboard'),
//                     ),
//                   ),
//                 ]
//               : [],
//         ),
//       );
//     },
//   );
// }


// // void showAppPopup(BuildContext context, String message,
// //     {bool isError = false}) {
// //   showDialog(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (BuildContext context) {
// //       Future.delayed(const Duration(seconds: 3), () {
// //         if (Navigator.of(context).canPop()) {
// //           Navigator.of(context).pop();
// //         }
// //       });

// //       return AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         content: Row(
// //           children: [
// //             Icon(
// //               isError ? Icons.error_outline : Icons.check_circle_outline,
// //               color: isError ? Colors.redAccent : Colors.green,
// //               size: 28,
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(message, style: const TextStyle(fontSize: 16)),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   );
// // // }

// // void popupfxn_with_msg(BuildContext context, String message,
// //     {bool isError = false, VoidCallback? onClose}) {
// //   showDialog(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (BuildContext context) {
// //       // Auto-navigate to dashboard after 5 seconds for success messages
// //       if (!isError) {
// //         Future.delayed(const Duration(seconds: 5), () {
// //           if (Navigator.of(context).canPop()) {
// //             Navigator.of(context).pop();
// //             Navigator.pushNamed(context, '/dashboard');
// //           }
// //         });
// //       }
// //       return AlertDialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         content: Row(
// //           children: [
// //             Icon(
// //               isError ? Icons.error : Icons.check_circle,
// //               color: isError ? Colors.red : Colors.green,
// //               size: 28,
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 message,
// //                 style: const TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           NouvaButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //               if (!isError && onClose != null) {
// //                 onClose();
// //               }
// //             },
// //             text: isError ? 'Close' : 'Go to Dashboard',
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }




// // void popupfxn_with_msg(BuildContext context, String message) {
// //   showDialog(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (BuildContext context) {
// //       Future.delayed(const Duration(seconds: 2), () {
// //         Navigator.of(context).pop(); // close after 2 sec
// //       });

// //       return AlertDialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         content: Row(
// //           children: [
// //             const Icon(Icons.check_circle, color: Colors.green, size: 28),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 message,
// //                 style: const TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   );
// // }



// // void popupfxn_with_msg(BuildContext context) {
// //   showDialog(
// //     context: context,
// //     barrierDismissible: false, // user can't close manually
// //     builder: (BuildContext context) {
// //       Future.delayed(const Duration(seconds: 2), () {
// //         Navigator.of(context).pop(); // close after 2 sec
// //       });

// //       return AlertDialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         content: Row(
// //           children: const [
// //             Icon(Icons.check_circle, color: Colors.green, size: 28),
// //             SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 "Quote saved successfully!",
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   );
// // }
