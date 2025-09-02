import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoverSelectionModel(),
      child: const RoyalMedApp(),
    ),
  );
}

class RoyalMedApp extends StatelessWidget {
  const RoyalMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Royal Med',
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.teal[400],
        ).copyWith(
          surface: Colors.grey[50],
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900]),
          headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blue[800]),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          labelLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue[700],
            side: BorderSide(color: Colors.blue[700]!),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        cardTheme: CardThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: Colors.blue.withOpacity(0.1),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        useMaterial3: true,
      ),
      home: const MainFlowPage(),
    );
  }
}

class CoverSelectionModel with ChangeNotifier {
  String? coverType;
  DateTime? myDob;
  DateTime? spouseDob;
  int numberOfChildren = 0;
  List<DateTime?> childrenDobs = [];
  String? coverAmount;

  void setCoverType(String type) {
    coverType = type;
    if (type != 'My Family') {
      numberOfChildren = 0;
      childrenDobs = [];
    }
    if (type == 'Me') {
      spouseDob = null;
    }
    notifyListeners();
  }

  void setMyDob(DateTime dob) {
    myDob = dob;
    notifyListeners();
  }

  void setSpouseDob(DateTime? dob) {
    spouseDob = dob;
    notifyListeners();
  }

  void setNumberOfChildren(int count) {
    numberOfChildren = count;
    childrenDobs = List.generate(count, (_) => null);
    notifyListeners();
  }

  void setChildDob(int index, DateTime dob) {
    childrenDobs[index] = dob;
    notifyListeners();
  }

  void setCoverAmount(String amount) {
    coverAmount = amount;
    notifyListeners();
  }

  double calculatePremium() {
    // Placeholder formula (to be provided later)
    double basePremium = 1000;
    if (coverType == 'Me & Spouse') basePremium *= 1.5;
    if (coverType == 'My Family') basePremium *= (2 + numberOfChildren * 0.5);
    if (coverAmount == '1M') basePremium *= 1.5;
    if (coverAmount == '2M') basePremium *= 2;
    return basePremium;
  }

  bool get isCoverTypeSelected => coverType != null;
  bool get isDetailsComplete {
    if (myDob == null) return false;
    if ((coverType == 'Me & Spouse' || coverType == 'My Family') &&
        spouseDob == null) return false;
    if (coverType == 'My Family') {
      return numberOfChildren > 0
          ? childrenDobs.every((dob) => dob != null)
          : true;
    }
    return true;
  }

  bool get isAmountSelected => coverAmount != null;
}

class MainFlowPage extends StatefulWidget {
  const MainFlowPage({super.key});

  @override
  State<MainFlowPage> createState() => _MainFlowPageState();
}

class _MainFlowPageState extends State<MainFlowPage> {
  bool _showDetails = false;
  bool _showAmount = false;
  bool _showSummary = false;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CoverSelectionModel>(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Royal Med'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 64.0 : 24.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Animate(
                effects: const [
                  FadeEffect(duration: Duration(milliseconds: 500))
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Royal Med',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Secure your health with tailored medical cover plans.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              // Cover Type Selection
              Animate(
                effects: const [
                  SlideEffect(
                      begin: Offset(0, 0.2),
                      duration: Duration(milliseconds: 400))
                ],
                child: CoverTypeSelection(
                  onSelected: () {
                    setState(() {
                      _showDetails = true;
                    });
                  },
                ),
              ),
              if (_showDetails) ...[
                const SizedBox(height: 32),
                Animate(
                  effects: const [
                    FadeEffect(delay: Duration(milliseconds: 200))
                  ],
                  child: PersonalDetailsSection(
                    onComplete: () {
                      setState(() {
                        _showAmount = true;
                      });
                    },
                  ),
                ),
              ],
              if (_showAmount) ...[
                const SizedBox(height: 32),
                Animate(
                  effects: const [
                    SlideEffect(
                        begin: Offset(0, 0.2),
                        delay: Duration(milliseconds: 300))
                  ],
                  child: CoverAmountSelection(
                    onSelected: () {
                      setState(() {
                        _showSummary = true;
                      });
                    },
                  ),
                ),
              ],
              if (_showSummary) ...[
                const SizedBox(height: 32),
                Animate(
                  effects: const [
                    FadeEffect(delay: Duration(milliseconds: 400))
                  ],
                  child: const SummarySection(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CoverTypeSelection extends StatelessWidget {
  final VoidCallback onSelected;

  const CoverTypeSelection({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CoverSelectionModel>(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Cover Type',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CoverTypeCard(
                  title: 'Me',
                  icon: Icons.person,
                  selected: model.coverType == 'Me',
                  onTap: () {
                    model.setCoverType('Me');
                    onSelected();
                  },
                  width: isLargeScreen
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth,
                ),
                CoverTypeCard(
                  title: 'Me & Spouse',
                  icon: Icons.favorite,
                  selected: model.coverType == 'Me & Spouse',
                  onTap: () {
                    model.setCoverType('Me & Spouse');
                    onSelected();
                  },
                  width: isLargeScreen
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth,
                ),
                CoverTypeCard(
                  title: 'My Family',
                  icon: Icons.family_restroom,
                  selected: model.coverType == 'My Family',
                  onTap: () {
                    model.setCoverType('My Family');
                    onSelected();
                  },
                  width: isLargeScreen
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CoverTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final double width;

  const CoverTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: selected ? Colors.blue[50] : null,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 48, color: Theme.of(context).primaryColor),
                const SizedBox(height: 8),
                Text(title, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersonalDetailsSection extends StatelessWidget {
  final VoidCallback onComplete;

  const PersonalDetailsSection({super.key, required this.onComplete});

  Future<void> _selectDate(
      BuildContext context, Function(DateTime) onDateSelected,
      [DateTime? initialDate]) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CoverSelectionModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // My DOB
                InkWell(
                  onTap: () =>
                      _selectDate(context, model.setMyDob, model.myDob),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Your Date of Birth',
                    ),
                    child: Text(
                      model.myDob != null
                          ? DateFormat.yMMMd().format(model.myDob!)
                          : 'Select Date',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                if (model.coverType == 'Me & Spouse' ||
                    model.coverType == 'My Family') ...[
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context,
                        (date) => model.setSpouseDob(date), model.spouseDob),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Spouse Date of Birth',
                      ),
                      child: Text(
                        model.spouseDob != null
                            ? DateFormat.yMMMd().format(model.spouseDob!)
                            : 'Select Date',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
                if (model.coverType == 'My Family') ...[
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Number of Children',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final count = int.tryParse(value) ?? 0;
                      model.setNumberOfChildren(count);
                    },
                  ),
                  const SizedBox(height: 16),
                  for (int i = 0; i < model.numberOfChildren; i++) ...[
                    InkWell(
                      onTap: () => _selectDate(
                          context,
                          (date) => model.setChildDob(i, date),
                          model.childrenDobs[i]),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Child ${i + 1} Date of Birth',
                        ),
                        child: Text(
                          model.childrenDobs[i] != null
                              ? DateFormat.yMMMd()
                                  .format(model.childrenDobs[i]!)
                              : 'Select Date',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    if (i < model.numberOfChildren - 1)
                      const SizedBox(height: 16),
                  ],
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: model.isDetailsComplete ? onComplete : null,
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}

class CoverAmountSelection extends StatelessWidget {
  final VoidCallback onSelected;

  const CoverAmountSelection({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CoverSelectionModel>(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Cover Amount',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CoverAmountCard(
                  amount: '500K',
                  selected: model.coverAmount == '500K',
                  onTap: () {
                    model.setCoverAmount('500K');
                    onSelected();
                  },
                  width: isLargeScreen
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth,
                ),
                CoverAmountCard(
                  amount: '1M',
                  selected: model.coverAmount == '1M',
                  onTap: () {
                    model.setCoverAmount('1M');
                    onSelected();
                  },
                  width: isLargeScreen
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth,
                ),
                CoverAmountCard(
                  amount: '2M',
                  selected: model.coverAmount == '2M',
                  onTap: () {
                    model.setCoverAmount('2M');
                    onSelected();
                  },
                  width: isLargeScreen
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CoverAmountCard extends StatelessWidget {
  final String amount;
  final bool selected;
  final VoidCallback onTap;
  final double width;

  const CoverAmountCard({
    super.key,
    required this.amount,
    required this.selected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: selected ? Colors.blue[50] : null,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                amount,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CoverSelectionModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plan Summary',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryItem(
                    label: 'Cover Type', value: model.coverType ?? 'N/A'),
                SummaryItem(
                  label: 'Your DOB',
                  value: model.myDob != null
                      ? DateFormat.yMMMd().format(model.myDob!)
                      : 'N/A',
                ),
                if (model.coverType == 'Me & Spouse' ||
                    model.coverType == 'My Family')
                  SummaryItem(
                    label: 'Spouse DOB',
                    value: model.spouseDob != null
                        ? DateFormat.yMMMd().format(model.spouseDob!)
                        : 'N/A',
                  ),
                if (model.coverType == 'My Family') ...[
                  SummaryItem(
                      label: 'Number of Children',
                      value: model.numberOfChildren.toString()),
                  for (int i = 0; i < model.numberOfChildren; i++)
                    SummaryItem(
                      label: 'Child ${i + 1} DOB',
                      value: model.childrenDobs[i] != null
                          ? DateFormat.yMMMd().format(model.childrenDobs[i]!)
                          : 'N/A',
                    ),
                ],
                SummaryItem(
                    label: 'Cover Amount', value: model.coverAmount ?? 'N/A'),
                const Divider(height: 24),
                SummaryItem(
                  label: 'Estimated Premium',
                  value: '\$${model.calculatePremium().toStringAsFixed(2)}',
                  isBold: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              // Placeholder for payment
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Proceed to Payment (Coming Soon)')),
              );
            },
            child: const Text('Proceed to Payment'),
          ),
        ),
      ],
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const SummaryItem({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
