import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_haven/core/theme/mycolors.dart';
import 'package:hair_haven/presentation/pages/barber-booking-screens/barber_booking_done_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';
class DateAndTimeScreen extends StatefulWidget {
  final String BarberName;
  final String BarberTitle;
  final String BarberServiceId;
  final String BarberAddress;
  final String BarberImg;
  const DateAndTimeScreen({Key?key, required this.BarberName, required this.BarberServiceId, required this.BarberAddress, required this.BarberTitle, required this.BarberImg}):super(key: key);



  @override
  State<DateAndTimeScreen> createState() => _DateAndTimeScreenState();
}

class _DateAndTimeScreenState extends State<DateAndTimeScreen> {

  String? _selectedTime;
  String? _selectedTime2;
  List<String> timeOptions = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
  ];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedTime="10:00 AM";
    _selectedTime2="11:00 AM";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.primaryColor
              ),
            ),
            Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(  CupertinoIcons.arrow_left, color: Colors.white, size: 22, ),
                )
            )
          ],
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        title: Text("Date and Time", style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            color: Colors.black
        )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
            children: [
              SizedBox(height: 20.h,),
              Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Color(0xffE3FFFC),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TableCalendar(
                          locale: 'en_US',
                          firstDay: DateTime.utc(2021, 1, 1),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          daysOfWeekHeight: 33.h,
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            headerPadding: EdgeInsets.symmetric(vertical: 5),
                            formatButtonDecoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp
                            ),
                            weekendStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                            ),
                          ),
                          calendarStyle: CalendarStyle(
                            selectedDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.primaryColor
                            ),
                            todayDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.primaryColor.withOpacity(0.4)
                            ),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Text("Pick Time", style: GoogleFonts.roboto(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                color: Colors.black
              ),),
              SizedBox(height: 20.h,),
              Container(
                height: 20.h,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  children: [
                    Expanded(
                        child: Text("From", style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                    ),
                    Expanded(
                        child: Text("To", style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                height: 40.h,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(10.r)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonFormField<String>(
                                value: _selectedTime,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedTime = newValue;
                                  });
                                },
                                items: timeOptions.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: _selectedTime==value?Colors.white:Colors.black
                                    ),),
                                  );
                                }).toList(),
                                icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.white,),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(10.r)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonFormField<String>(
                                value: _selectedTime2,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedTime2 = newValue;
                                  });
                                },
                                items: timeOptions.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: _selectedTime2==value?Colors.white:Colors.black
                                    ),
                                    ),
                                  );
                                }).toList(),
                                icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.white,),
                                decoration: InputDecoration(
                                  labelText: null,
                                  border: InputBorder.none,
                                  // Add additional decoration properties as needed
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                child: Container(
                    height: 50.h,
                    width: 358.w,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: TextButton(
                      child: Text("Book Barber", style:GoogleFonts.lora(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),),
                      onPressed: (){
                        BookedBarberDetails.BookedBarberNames.add(widget.BarberName);
                        BookedBarberDetails.BookedBarberTitles.add(widget.BarberTitle);
                        BookedBarberDetails.BookedBarberAdds.add(widget.BarberAddress);
                        BookedBarberDetails.BookedBarberProfiles.add(widget.BarberImg);
                        BookedBarberDetails.BookedBarberServiceIds.add(widget.BarberServiceId);
                        BookedBarberDetails.BookedBarberDates.add(_selectedDay!.month.toString()+" "+_selectedDay!.day.toString()+", "+_selectedDay!.year.toString());
                        BookedBarberDetails.BookedBarberTimes.add(_selectedTime.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return BarberBookingDoneScreen();
                        }));
                      },
                    )
                ),
              ),
            ],
        ),
      )
    );
  }
}
class BookedBarberDetails{
  static List<String>BookedBarberNames=[];
  static List<String>BookedBarberTitles=[];
  static List<String>BookedBarberServiceIds=[];
  static List<String>BookedBarberAdds=[];
  static List<String>BookedBarberProfiles=[];
  static List<String>BookedBarberDates=[];
  static List<String>BookedBarberTimes=[];
}
