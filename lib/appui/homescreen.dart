// import 'package:doctor_doom/appui/Schedule.dart';
import 'package:doctor_doom/appui/account.dart';
import 'package:doctor_doom/appui/joinmeeting2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/homeui1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 25.0, bottom: 5.0, left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.solidUserCircle,
                      color: Color.fromARGB(255, 232, 156, 16),
                      size: 45,
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountScreen()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 115,
              ),
              Text(
                'Be more\nProductive,\nand Efficient\nWork with Teams...',
                style: GoogleFonts.barrio(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  shadows: [
                    Shadow(
                      color: const Color(0xFF808080).withOpacity(0.5),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child:
                    // ActionButton(
                    //   label: "Schedule Now",
                    //   onPressed: () {
                    //     Navigator.of(context).push(PageRouteBuilder(
                    //       pageBuilder:
                    //           (context, animation, secondaryAnimation) =>
                    //               ScheduleMeetingScreen(),
                    //       transitionsBuilder:
                    //           (context, animation, secondaryAnimation, child) {
                    //         const curve = Curves.easeInOut;

                    //         return Stack(
                    //           children: [
                    //             SlideTransition(
                    //               position: Tween<Offset>(
                    //                 begin: Offset(1.5, 0),
                    //                 end: Offset.zero,
                    //               ).animate(CurvedAnimation(
                    //                 parent: animation,
                    //                 curve: curve,
                    //               )),
                    //               child: Container(color: Colors.blue),
                    //             ),
                    //             SlideTransition(
                    //               position: Tween<Offset>(
                    //                 begin: Offset(1.0, 0),
                    //                 end: Offset.zero,
                    //               ).animate(CurvedAnimation(
                    //                 parent: animation,
                    //                 curve: curve,
                    //               )),
                    //               child: child,
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     ));
                    //   },
                    // ),
                    // const SizedBox(height: 20),
                    // const SizedBox(height: 20),
                    ActionButton(
                  label: "Join Meeting",
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Joinmeeting2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const curve = Curves.easeInOut;

                        return Stack(
                          children: [
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(1.5, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: curve,
                              )),
                              child: Container(color: Colors.blue),
                            ),
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(1.0, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: curve,
                              )),
                              child: child,
                            ),
                          ],
                        );
                      },
                    ));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
