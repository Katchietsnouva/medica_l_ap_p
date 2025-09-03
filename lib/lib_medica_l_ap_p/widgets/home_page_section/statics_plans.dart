// lib/lib_medica_l_ap_p/widgets/home_page_section/statics_plans.dart

List<Map<String, dynamic>> extractPlans(Map<String, dynamic> json) {
  List<Map<String, dynamic>> plansList = [];

  if (json['status'] != 'success' || json['options'] == null) {
    return plansList; // empty list
  }

  final options = json['options'] as List<dynamic>;

  for (final option in options) {
    final plans = option['plans'] as List<dynamic>?;

    if (plans == null) continue;

    for (final plan in plans) {
      final planName = plan['Plan'];
      final optionsList = plan['Options'] as List<dynamic>?;

      if (optionsList == null) continue;

      for (final optionEntry in optionsList) {
        final premiumList =
            optionEntry['rates']?['INPATIENT SHARED'] as List<dynamic>?;

        if (premiumList == null || premiumList.isEmpty) continue;

        final premium = premiumList[0]['premium'];
        final coverage = optionEntry['Option'];

        plansList.add({
          'planName': planName,
          'premium': premium,
          'coverage': coverage,
          'insurer': option['insurer'],
        });
      }
    }
  }

  return plansList;
}

const Map<String, dynamic> staticPlansData = {
  "status": "success",
  "message": "Quote generated successfully",
  "options": [
    {
      "insurer": "APA",
      "insurer_id": 1,
      "plans": [
        {
          "Plan": "Royalmed Exe",
          "Options": [
            {
              "Option": "500000",
              "limit": 500000,
              "rates": {
                "INPATIENT SHARED": [
                  {"premium": 23000}
                ]
              }
            }
          ]
        },
        {
          "Plan": "Royal Pre",
          "Options": [
            {
              "Option": "500000",
              "limit": 500000,
              "rates": {
                "INPATIENT SHARED": [
                  {"premium": 31000}
                ]
              }
            }
          ]
        }
      ]
    }
  ]
};
