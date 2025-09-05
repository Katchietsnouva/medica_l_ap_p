// screens/terms_and_conditions_page.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/widgets/universal_page_layout.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: CustomScrollView(
    return UniversalPageLayout(
      slivers: [
        // SliverAppBar(
        //   pinned: true,
        //   expandedHeight: 100.0,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: const Text('Terms & Conditions',
        //         style: TextStyle(color: Colors.white)),
        //     background: Container(
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [Colors.blue, Colors.lightBlueAccent],
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //         ),
        //       ),
        //       // child: const Icon(Icons.gavel, size: 80, color: Colors.white54),
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Padding(
            // padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    _buildSectionTitle(context, 'Frequently Asked Questions'),
                    const SizedBox(height: 32),
                    _buildFaqSection(),
                    const SizedBox(height: 32),
                    _buildSectionTitle(context, 'Declaration'),
                    const SizedBox(height: 16),
                    _buildDeclarationCard(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
      // ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFaqSection() {
    return const Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          FaqTile(
            question: '1. What is Deliverance Church Last Expense?',
            answer:
                'To promote a Christ-like character by supporting the members of the congregation spiritual and financial needs for the challenged members of the congregation.',
          ),
          FaqTile(
            question:
                '2. What are the benefits of Deliverance Church Last Expense?',
            answer:
                'On the demise of a principal member or a dependant, the cover pays a benefit of Kshs 2,500 or Kshs 1,250 for the extended family member. The cover is administered after payment of a claim within 12 months of policy commencement or renewal. FULL premium must have been paid.',
          ),
          FaqTile(
            question: '3. What is the claim reporting and documentation?',
            answer: 'Within 48 hours of family reporting and documentation.',
          ),
          FaqTile(
            question: '4. How much will it cost?',
            answer:
                'The principal member pays either Kshs 2,500 or Kshs 1,250 to cover the Principal Member and 5 members of their nuclear family (spouse and 4 children or 5 children for single parents) and 4 members of their extended family.',
          ),
          FaqTile(
            question:
                '5. What happens if my dependants are more than the 5 or 4 members?',
            answer:
                'You can add more than 5 dependants (Kshs 250 for each additional member) depending on the level of cover chosen.',
          ),
          FaqTile(
            question: '6. Who can be covered under the policy?',
            answer:
                'Principal member age 18 to 65. Spouse 18 to 65. Children up to age 24 if in school/college, parents and parents-in-law. The cover is limited for parents, special parents and parents-in-law to 4 years in a row. On withdrawal, the policy will be covered up to the age of 85 years.',
          ),
          FaqTile(
            question: '7. What are the Exclusions?',
            answer:
                'a) Suicide, participation in any hazardous pursuit or sport including racing on wheels or on horseback, mountaineering, fighting other than in self-defence, civil war, rebellion, revolution, riot, civil commotion or any act of terrorism.\n'
                'b) Active participation by the member whether declared or not, invasion, acts of foreign enemies, hostilities, civil war, rebellion, revolution, insurrection or military or usurped power, riot or civil commotion, or any act of any person acting on behalf of or in connection with any organization, the object of which are to include the overthrowing by force of any de jure or de facto government or to influence any government and/or public by force or by any other means originating from any political or civil unrest.\n'
                'c) Intake of drugs and/or alcohol unless on medical prescription by authorized/registered medical personnel.\n'
                'd) Participation in any hazardous pursuit or sport including racing on wheels, mountaineering, or fighting except in bona fide self-defence.\n'
                'e) Any nuclear reaction or radiation.\n'
                'f) Unless the policy is extended to be so, intentional self-injury or attempted suicide, whether felonious or not, provided always that the cover will not be invalidated if the insured person dies as a result of any injury received in an attempt to save a human life.\n'
                'g) War, invasion, acts of foreign enemies, hostilities (whether war is declared or not), civil war, rebellion, revolution, insurrection or military or usurped power or confiscation or nationalization or requisition of or damage to property by or under the order of any government or public or local authority.\n'
                'h) The radioactive or ionizing effect of any nuclear weeks from the combustion of nuclear fuel.',
          ),
          FaqTile(
            question:
                '8. You give false/fraudulent/intentionally exaggerated information.',
            answer:
                'Yes, we can refuse to pay a claim if you give false/fraudulent/intentionally exaggerated information as per original documents.',
          ),
          FaqTile(
            question:
                '9. Are there circumstances the insurance may fail to pay a claim?',
            answer:
                'Yes, but one can review the cover through paying for the remaining members of his/her family.',
          ),
          FaqTile(
            question:
                '10. Are there circumstances the insurance may fail to pay a claim if the step-father or step-mother fails to remit premiums on their behalf?',
            answer:
                'No, you can only give cash or cheques to Deliverance Church Last Expense. In case of cash, you should be issued with a receipt. Note: You cannot be a beneficiary in a case where you pay the premiums on their behalf.',
          ),
        ],
      ),
    );
  }

  Widget _buildDeclarationCard(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Important Declaration',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'I declare that the statements and particulars on this form are true and that I have not misstated or withheld and material facts. I agree that this application and the statements and particulars together with any report supplied shall form the basis of the insurance contract offered hereon. I have read and understood the terms and conditions set out in this policy.',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const FaqTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title:
          Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      expandedAlignment: Alignment.topLeft,
      children: [
        Text(answer, style: const TextStyle(height: 1.5)),
      ],
    );
  }
}
