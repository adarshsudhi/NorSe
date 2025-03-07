import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutpage extends StatefulWidget {
  static const String aboutpage = './aboutpage';
  const Aboutpage({super.key});

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  bool loading = true;

  _call() async {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _call();
  }

  void _copyToClipboard(BuildContext context, String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    Spaces.showtoast('Copied to Clipboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Textutil(
            text: 'About',
            fontsize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: loading != true
          ? SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: 1,
                      left: 190,
                      child: Image.asset(
                        'assets/icon.png',
                        scale: 1.2,
                      )),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.9)),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Spaces.kheight10,
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              'assets/icon.png',
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 1.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                const Textutil(
                                    text: 'NorSe Music',
                                    fontsize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                const Textutil(
                                    text: Spaces.version,
                                    fontsize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                Spaces.kheight10,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Build with ",
                                      style: Spaces.Getstyle(
                                          10, Colors.white, FontWeight.normal),
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                    Text(
                                      ' by Adarsh N S ',
                                      style: Spaces.Getstyle(
                                          10, Colors.white, FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ]),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'NorSe is an Opensource project and can be found in here',
                                  style: GoogleFonts.aldrich(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: InkWell(
                                  onTap: () async {
                                    Uri uri = Uri.parse(
                                        'https://github.com/adarshsudhi');
                                    await launchUrl(uri);
                                  },
                                  child: Image.asset('assets/git.png'),
                                ),
                              ),
                              const Textutil(
                                  text: 'Connect with me on',
                                  fontsize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Uri uri = Uri.parse(
                                          'https://www.instagram.com/_adarsh_ns/?igsh=aDVqdXJrY2Nrczh0');
                                      await launchUrl(uri);
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          'assets/instagram.png',
                                        )),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: Center(
                                        child: Text(
                                      '   OR   ',
                                      style: Spaces.Getstyle(
                                          8, Colors.white, FontWeight.normal),
                                    )),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Uri uri = Uri.parse(
                                          'https://www.linkedin.com/in/adarsh-n-s-97b3a0246?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child:
                                            Image.asset('assets/linkedin.png')),
                                  )
                                ],
                              ),
                              const Textutil(
                                  text: 'if you like my work',
                                  fontsize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              SizedBox(
                                height: 50,
                                width: 130,
                                child: InkWell(
                                  onTap: () async {
                                    String url =
                                        'https://www.buymeacoffee.com/adarshadarz';

                                    await launchUrl(Uri.parse(url));
                                  },
                                  child: Image.asset('assets/bmc.png'),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Center(
                                    child: Text(
                                  '   OR   ',
                                  style: Spaces.Getstyle(
                                      8, Colors.white, FontWeight.normal),
                                )),
                              ),
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: InkWell(
                                  onTap: () async {
                                    showDialog(
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          surfaceTintColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          child: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height /
                                                2,
                                            child: Stack(
                                              children: [
                                                Image.asset('assets/payy.png'),
                                                Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton.icon(
                                                          onPressed: () {
                                                            _copyToClipboard(
                                                                context,
                                                                'adarshadar543-1@okaxis');
                                                          },
                                                          icon: const Icon(
                                                            Icons.copy,
                                                            color: Colors.black,
                                                            size: 15,
                                                          ),
                                                          label: const Textutil(
                                                              text: 'Copy',
                                                              fontsize: 10,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Textutil(
                                              text: 'Donate',
                                              fontsize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          Image.asset('assets/pay.png'),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
            ),
    );
  }
}
