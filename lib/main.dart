import 'package:flutter/material.dart';
import 'package:tip_calculator_flutter/widgets/bill_amount_fill.dart';
import 'package:tip_calculator_flutter/widgets/person_counter.dart';
import 'package:tip_calculator_flutter/widgets/tip_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Track the theme state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Toggle theme
      home: UTip(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value; // Update the theme state
          });
        },
      ),
    );
  }
}

class UTip extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const UTip({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCounter = 1;
  double sliderValue = 0.0;
  double billAmountValue = 0.0;

  double totalPerPerson() {
    return ((billAmountValue * sliderValue) + (billAmountValue)) /
        _personCounter;
  }

  double totalTip() {
    return billAmountValue * sliderValue;
  }

  void increament() {
    setState(() {
      _personCounter++;
    });
  }

  void decreament() {
    setState(() {
      if (_personCounter > 1) _personCounter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double total = totalPerPerson();
    double tip = totalTip();
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tip Calculator"),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged, // Toggle theme
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Total per Person", style: style),
                  Text(
                    total.toStringAsFixed(2),
                    style: style.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontSize: theme.textTheme.displaySmall?.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  BillAmountField(
                    billAmount: billAmountValue.toString(),
                    onChanged: (value) {
                      setState(() {
                        billAmountValue = double.parse(value);
                      });
                    },
                  ),
                  PersonCounter(
                    theme: theme,
                    personCounter: _personCounter,
                    onDecrement: decreament,
                    onIncrement: increament,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip", style: theme.textTheme.titleMedium),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            tip.toStringAsFixed(2),
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "${(sliderValue * 100).round()}%",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  TipSlider(
                    sliderValue: sliderValue,
                    onSliderChange: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}