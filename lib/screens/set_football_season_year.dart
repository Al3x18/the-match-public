import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:the_match/utils/globals.dart';

class SetFootballSeasonYear extends StatefulWidget {
  const SetFootballSeasonYear({super.key, required this.currentSeasonYear});

  final String currentSeasonYear;

  @override
  State<SetFootballSeasonYear> createState() => _SetSeasonYearState();
}

class _SetSeasonYearState extends State<SetFootballSeasonYear> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  int currentYear = DateTime.now().year;
  String _seasonYear = "";
  int minSeasonYear = int.tryParse(SET_MIN_SEASON_YEAR_FOOTBALL)!;
  bool shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    _seasonYear = widget.currentSeasonYear;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 90),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -7, end: 7).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _onKeyboardTap(String value) {
    setState(() {
      if (_seasonYear.length < 4) {
        _seasonYear = _seasonYear + value;
      }
    });
  }

  void _setSeasonYear() async {
    if (_seasonYear.length == 4 && int.tryParse(_seasonYear)! >= minSeasonYear && int.tryParse(_seasonYear)! <= currentYear) {
      Get.back(result: _seasonYear);
    } else {
      final canVibrate = await Haptics.canVibrate();
      if (canVibrate) {
        await Haptics.vibrate(HapticsType.error);
      }

      setState(() {
        shouldAnimate = true;
      });
      _animationController.forward().then((_) {
        _animationController.reverse();
        setState(() {
          shouldAnimate = false;
        });
      });
    }
  }

  String generateSlashData(String seasonYear) {
    String textToReturn = "";

    bool checkIfSeasonYearSubStringHasOneDigit() {
      return (int.tryParse(_seasonYear.substring(2))! + 1).toString().length == 1;
    }

    if (seasonYear.length == 4) {
      return textToReturn = "/${checkIfSeasonYearSubStringHasOneDigit() ? "0${int.tryParse(_seasonYear.substring(2))! + 1}" : int.tryParse(_seasonYear.substring(2))! + 1}";
    } else {
      return textToReturn;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Football Season Year"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: shouldAnimate ? Offset(_animation.value, 0) : Offset.zero,
                      child: child,
                    );
                  },
                  child: Text(
                    "The year must be in YYYY format and must be between $minSeasonYear and the $currentYear",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13.8),
                  ),
                ),
              ),
              const Spacer(),
              Visibility(
                visible: !(_seasonYear.length == 4),
                child: Text(
                  "Currently Selected: ${widget.currentSeasonYear}/${int.tryParse(widget.currentSeasonYear.substring(2))! + 1}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.4,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _seasonYear,
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                          color: isDark ? Colors.white : Colors.black,
                          fontSizeFactor: 2.3,
                          fontWeightDelta: 2,
                        ),
                  ),
                  Visibility(
                    visible: _seasonYear.length == 4,
                    child: Text(
                      generateSlashData(_seasonYear),
                      style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Colors.grey,
                            fontSizeFactor: 2.3,
                            fontWeightDelta: 2,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: _seasonYear.length == 4,
                child: SizedBox(
                  height: HEIGHT_OF_SAVE_BUTTON,
                  width: WIDTH_OF_SAVE_BUTTON,
                  child: ElevatedButton(
                    onPressed: () => _setSeasonYear(),
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(SAVE_BUTTON_ELEVATION),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(SAVE_BUTTON_RADIUS))),
                      side: const WidgetStatePropertyAll(BorderSide(color: Colors.black, width: SAVE_BUTTON_BORDER_WIDTH)),
                      backgroundColor: WidgetStateProperty.all(SAVE_BUTTON_BACKGROUND_COLOR),
                      foregroundColor: WidgetStateProperty.all(SAVE_BUTTON_FOREGROUND_COLOR),
                    ),
                    child: const Text(SAVE_BUTTON_TEXT),
                  ),
                ),
              ),
              const Spacer(),
              NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textStyle: TextStyle(fontSize: 20.5, color: isDark ? Colors.white : Colors.black),
                  rightButtonFn: () {
                    if (_seasonYear.isEmpty) return;
                    setState(() {
                      _seasonYear = _seasonYear.substring(0, _seasonYear.length - 1);
                    });
                  },
                  rightButtonLongPressFn: () {
                    if (_seasonYear.isEmpty) return;
                    setState(() {
                      _seasonYear = '';
                    });
                  },
                  rightIcon: const Icon(
                    Icons.backspace,
                    color: Colors.red,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
