import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'text_widget.dart';

/// Defines the default color scheme used by the Hijri calendar.
class HijriColor {
  /// Primary color used for main elements and text
  static const Color primary = Color(0xFF318051);

  /// Secondary color used for Gregorian dates and supplementary elements
  static const Color secondary = Color(0xFFFB9B00);

  /// Grey color used for borders and inactive elements
  static const Color grey = Color(0xFFCED3DE);
}

/// A customizable Hijri (Islamic) calendar widget that displays both Hijri and
/// Gregorian dates with support for event marking and date selection.
///
/// Features:
/// - Month navigation with smooth animations
/// - Display of corresponding Gregorian dates
/// - Support for highlighting important Islamic dates
/// - Custom event date highlighting
/// - Optional header and UI elements
class TrueHijriCalendar extends StatefulWidget {
  /// The currently active Hijri date (typically today)
  final HijriCalendar currentDate;

  /// Optional primary color for the calendar (defaults to HijriColor.primary)
  final Color? primaryColor;

  /// Optional secondary color for the calendar (defaults to HijriColor.secondary)
  final Color? secondaryColor;

  /// Callback function that returns the selected Hijri date and corresponding Gregorian date
  final Function(HijriCalendar?, DateTime)? onDateSelected;

  /// Callback function that returns the selected Hijri month date
  final Function(HijriCalendar?)? onSelectedHijriMonth;

  /// Optional list of Hijri dates to mark as events on the calendar
  final List<HijriCalendar>? eventDates;

  /// Whether to show the month/year header and navigation controls
  final bool showHeaderSection;

  /// Whether to show event indicators on dates
  final bool showEvent;

  /// Whether dates are selectable by tapping
  final bool isDateSelect;

  final int adjustmentNumber;

  const TrueHijriCalendar({
    super.key,
    required this.currentDate,
    this.onDateSelected,
    this.primaryColor,
    this.secondaryColor,
    this.eventDates,
    this.showHeaderSection = true,
    this.isDateSelect = false,
    this.showEvent = true,
    this.onSelectedHijriMonth,
    this.adjustmentNumber = 0,
  });

  @override
  State<TrueHijriCalendar> createState() => _TrueHijriCalendarState();
}

class _TrueHijriCalendarState extends State<TrueHijriCalendar> {
  late HijriCalendar _currentMonth;
  HijriCalendar? _selectedDate;
  late HijriCalendar _currentDate;
  late List<HijriCalendar> _eventDates = [];
  Color primary = HijriColor.primary;
  Color secondary = HijriColor.secondary;
  Color grey = HijriColor.grey;
  bool _isNext = true;
  bool _showHeaderSection = true;
  bool _showEvent = true;
  bool _isDateSelect = false;
  int _adjustment = 0;
  late DateTime? _selectedGregorianDate;

  final int _duration = 500;
  bool _isBtnActive = true;

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  void _initialization() {
    primary = widget.primaryColor ?? primary;
    secondary = widget.secondaryColor ?? secondary;
    _showHeaderSection = widget.showHeaderSection;
    _showEvent = widget.showEvent;
    _isDateSelect = widget.isDateSelect;
    _adjustment = widget.adjustmentNumber;

    // Initialize with the current date
    _currentDate = widget.currentDate;

    // Convert to Gregorian with adjustment applied
    var currentGregorianDate = HijriCalendar().hijriToGregorian(
      _currentDate.hYear,
      _currentDate.hMonth,
      _currentDate.hDay,
    );
    currentGregorianDate = currentGregorianDate.add(
      Duration(days: _adjustment),
    );

    // Set selected Gregorian date to today
    _selectedGregorianDate = DateTime.now();

    // Update current Hijri date based on adjusted Gregorian date
    _currentDate = HijriCalendar.fromDate(currentGregorianDate);

    // Set current month to first day of the month from provided currentDate
    _currentMonth =
        HijriCalendar()
          ..hYear = _currentDate.hYear
          ..hMonth = _currentDate.hMonth
          ..hDay = 1;

    // Initialize selected date to current date if isDateSelect is true
    if (_isDateSelect) {
      _selectedDate =
          HijriCalendar()
            ..hYear = _currentDate.hYear
            ..hMonth = _currentDate.hMonth
            ..hDay = _currentDate.hDay;
    }

    widget.onSelectedHijriMonth?.call(_currentMonth);
    _updateEventDates();
  }

  @override
  void didUpdateWidget(TrueHijriCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.adjustmentNumber != widget.adjustmentNumber) {
      setState(() {
        _initialization();
      });
    }
  }

  void _updateEventDates() {
    List<HijriCalendar> defaultEvents = getIslamicEventsForYear(
      _currentMonth.hYear,
    );
    if (widget.eventDates != null && widget.eventDates!.isNotEmpty) {
      _eventDates = [...defaultEvents, ...widget.eventDates!];
    } else {
      _eventDates = defaultEvents;
    }
  }

  List<HijriCalendar> getIslamicEventsForYear(int hijriYear) {
    return [
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 1
        ..hDay = 1, // Islamic New Year
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 1
        ..hDay = 10, // Ashura
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 7
        ..hDay = 27, // Isra and Miraj
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 8
        ..hDay = 15, // Mid-Sha'ban (Shab-e-Barat)
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 9
        ..hDay = 1, // Start of Ramadan
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 9
        ..hDay = 27, // Laylat al-Qadr (approx.)
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 10
        ..hDay = 1, // Eid al-Fitr
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 12
        ..hDay = 8, // Day of Arafah
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 12
        ..hDay = 9, // Hajj (9th Dhul-Hijjah)
      HijriCalendar()
        ..hYear = hijriYear
        ..hMonth = 12
        ..hDay = 10, // Eid al-Adha
    ];
  }

  // Modified to handle Gregorian date selection
  void _handleDateSelection(HijriCalendar hijriDate, DateTime gregDate) {
    setState(() {
      // Store the selected Gregorian date
      _selectedGregorianDate = gregDate;

      // Apply the adjustment to get the corresponding Hijri date

      DateTime adjustedGregDate = gregDate.add(Duration(days: _adjustment));
      HijriCalendar adjustedHijriDate = HijriCalendar.fromDate(
        adjustedGregDate,
      );

      // Update selected Hijri date
      _selectedDate =
          HijriCalendar()
            ..hYear = adjustedHijriDate.hYear
            ..hMonth = adjustedHijriDate.hMonth
            ..hDay = adjustedHijriDate.hDay;

      // Keep the current month view
      _currentMonth =
          HijriCalendar()
            ..hYear = hijriDate.hYear
            ..hMonth = hijriDate.hMonth
            ..hDay = 1;
    });

    // Pass both the adjusted Hijri date and original Gregorian date to the callback
    widget.onDateSelected?.call(_selectedDate, gregDate);
  }

  void _navigateToPreviousMonth() {
    if (_isBtnActive) {
      setState(() {
        _isNext = false;
      });
      Future.delayed(Duration.zero, () {
        setState(() {
          if (_currentMonth.hMonth == 1) {
            _currentMonth =
                HijriCalendar()
                  ..hYear = _currentMonth.hYear - 1
                  ..hMonth = 12
                  ..hDay = 1;

            // Update events for the new year
            _updateEventDates();
          } else {
            // Normal month transition
            _currentMonth =
                HijriCalendar()
                  ..hYear = _currentMonth.hYear
                  ..hMonth = _currentMonth.hMonth - 1
                  ..hDay = 1;
          }
          widget.onSelectedHijriMonth?.call(_currentMonth);
        });
      });
      _updateBtnStatus();
    }
  }

  void _navigateToNextMonth() {
    if (_isBtnActive) {
      setState(() {
        // Set animation direction to forward
        _isNext = true;
      });

      // Use Future.delayed to ensure animation is triggered properly
      Future.delayed(Duration.zero, () {
        setState(() {
          // Handle year transition (month 12 → month 1 of next year)
          if (_currentMonth.hMonth == 12) {
            _currentMonth =
                HijriCalendar()
                  ..hYear = _currentMonth.hYear + 1
                  ..hMonth = 1
                  ..hDay = 1;

            // Update events for the new year
            _updateEventDates();
          } else {
            // Normal month transition
            _currentMonth =
                HijriCalendar()
                  ..hYear = _currentMonth.hYear
                  ..hMonth = _currentMonth.hMonth + 1
                  ..hDay = 1;
          }
          widget.onSelectedHijriMonth?.call(_currentMonth);
        });
      });
      _updateBtnStatus();
    }
  }

  _updateBtnStatus() {
    _isBtnActive = false;
    Future.delayed(
      Duration(milliseconds: _duration),
      () => _isBtnActive = true,
    );
  }

  int _getHijriMonthLength(HijriCalendar month) {
    final firstDayGreg = month.hijriToGregorian(
      month.hYear,
      month.hMonth,
      1 - (_adjustment),
    );

    final nextMonth =
        HijriCalendar()
          ..hYear = (month.hMonth == 12) ? month.hYear + 1 : month.hYear
          ..hMonth = (month.hMonth % 12) + 1
          ..hDay = 1;

    final firstDayNextMonthGreg = nextMonth.hijriToGregorian(
      nextMonth.hYear,
      nextMonth.hMonth,
      1 - (_adjustment),
    );

    return firstDayNextMonthGreg.difference(firstDayGreg).inDays;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          _showHeaderSection ? _buildHeader(context) : const SizedBox.shrink(),
          _buildCalendarGrid(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(height * 0.016),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(height * 0.012),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(height * 0.012),
                  child: InkWell(
                    onTap: _navigateToPreviousMonth,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: height * 0.012,
                        vertical: height * 0.012,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.012),
                        border: Border.all(color: grey, width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black,
                          size: height * 0.018,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TextWidget(
                    text:
                        '${_currentMonth.getLongMonthName()}-${_currentMonth.hYear} AH',
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.w500,
                    textColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: height * 0.004),
                  TextWidget(
                    text: _getGregorianMonthRange(),
                    fontSize: height * 0.014,
                    fontWeight: FontWeight.w400,
                    textColor: Colors.yellowAccent,
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(height * 0.012),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(height * 0.012),
                  child: InkWell(
                    onTap: _navigateToNextMonth,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: height * 0.012,
                        vertical: height * 0.012,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.012),
                        border: Border.all(color: grey, width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: height * 0.018,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getGregorianMonthRange() {
    final firstDayGreg = _currentMonth.hijriToGregorian(
      _currentMonth.hYear,
      _currentMonth.hMonth,
      1 - (_adjustment),
    );

    final lastDay = _getHijriMonthLength(_currentMonth);

    final lastDayGreg = _currentMonth.hijriToGregorian(
      _currentMonth.hYear,
      _currentMonth.hMonth,
      lastDay - (_adjustment),
    );
    debugPrint("lastDayGreg====$lastDayGreg");
    return '${DateFormat('MMM yyyy').format(firstDayGreg)} - ${DateFormat('MMM yyyy').format(lastDayGreg)}';
  }

  Widget _buildCalendarGrid(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildWeekdayHeaders(context),
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              _navigateToNextMonth();
            } else if (details.primaryVelocity! > 0) {
              _navigateToPreviousMonth();
            }
          },
          child: TweenAnimationBuilder<double>(
            key: ValueKey('${_currentMonth.hYear}-${_currentMonth.hMonth}'),
            tween: Tween<double>(begin: _isNext ? 1.0 : -1.0, end: 0.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value * MediaQuery.of(context).size.width, 0),
                child: child,
              );
            },
            child: _buildDaysGridWithKey(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDaysGridWithKey(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey('${_currentMonth.hYear}-${_currentMonth.hMonth}'),
      child: _buildDaysGrid(context),
    );
  }

  Widget _buildWeekdayHeaders(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Padding(
      padding: EdgeInsets.only(top: height * 0.012),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 3,
        ),
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          return Center(
            child: TextWidget(
              text: weekdays[index],
              fontSize: height * 0.018,
              fontWeight: FontWeight.w500,
              textColor: Theme.of(context).primaryColor,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDaysGrid(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final daysInMonth = _getHijriMonthLength(_currentMonth);

    debugPrint("_buildDaysGrid=====daysInMonth====$daysInMonth");

    final firstDayGreg = _currentMonth.hijriToGregorian(
      _currentMonth.hYear,
      _currentMonth.hMonth,
      1 - (_adjustment),
    );
    final firstWeekday = firstDayGreg.weekday % 7;
    final emptyCells = firstWeekday == 7 ? 0 : firstWeekday;
    List<Widget> dayWidgets = [];

    for (int i = 0; i < emptyCells; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final hijriDay =
          HijriCalendar()
            ..hYear = _currentMonth.hYear
            ..hMonth = _currentMonth.hMonth
            ..hDay = day;

      // Convert to Gregorian date
      var gregDate = hijriDay.hijriToGregorian(
        hijriDay.hYear,
        hijriDay.hMonth,
        hijriDay.hDay,
      );

      // Apply adjustment to the Gregorian date if needed
      if (_adjustment != 0) {
        gregDate = gregDate.subtract(Duration(days: _adjustment));
      }

      // Check if the Gregorian date matches the selected Gregorian date
      final bool isSelected =
          _selectedGregorianDate != null &&
          _selectedGregorianDate?.year == gregDate.year &&
          _selectedGregorianDate?.month == gregDate.month &&
          _selectedGregorianDate?.day == gregDate.day;

      // Check if this day is the current date (today)
      final isCurrent =
          DateTime.now().year == gregDate.year &&
          DateTime.now().month == gregDate.month &&
          DateTime.now().day == gregDate.day;

      // Check if this day is marked as an event (still using Hijri dates)
      final bool isEvent = _eventDates.any(
        (event) =>
            event.hYear == hijriDay.hYear &&
            event.hMonth == hijriDay.hMonth &&
            event.hDay == hijriDay.hDay,
      );

      // Function to determine border color
      Color getColor() {
        if (isSelected) {
          return Colors.blue;
        } else {
          return Colors.transparent;
        }
      }

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            if (_isDateSelect) {
              _handleDateSelection(hijriDay, gregDate);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: height * 0.012),
            decoration: BoxDecoration(
              border: Border.all(
                color: !isCurrent ? getColor() : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(height * .014),
              color: isCurrent ? primary : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hijri date number
                Text(
                  day.toString(),
                  style: TextStyle(
                    color: isCurrent ? Colors.white : primary,
                    fontSize: height * 0.016,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: _showEvent ? 0 : height * 0.004),
                // Gregorian date number
                Text(
                  gregDate.day.toString(),
                  style: TextStyle(color: secondary, fontSize: height * 0.012),
                ),
                _showEvent
                    ? Column(
                      children: [
                        SizedBox(height: height * 0.002),
                        Container(
                          width: height * 0.006,
                          height: height * 0.006,
                          decoration: BoxDecoration(
                            color:
                                isEvent
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(height * 0.01),
                          ),
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
                _showEvent
                    ? SizedBox(height: height * 0.004)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        top: width < 500 ? height * 0.02 : height * 0.01,
      ),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: height * 0.003,
        mainAxisExtent: height * 0.055,
      ),
      itemCount: dayWidgets.length,
      itemBuilder: (context, index) {
        return dayWidgets[index];
      },
    );
  }
}
