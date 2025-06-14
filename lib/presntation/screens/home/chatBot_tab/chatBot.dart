// بقية import موجودة كما هي
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import '../../home/categories_item/categories_item.dart';
import '../../see_all/category_details/CategoryDetailsScreen.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  void _navigateToSpecialtyScreen(String specialty) {
    final category = CategoriesItem(
      title: specialty,
      imagePath: '',
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailsScreen(category: category),
      ),
    );
  }

  void _sendMessage(String message) {
    String time = DateFormat.jm().format(DateTime.now());

    setState(() {
      messages.add({'sender': 'user', 'message': message, 'time': time});
      final loc = AppLocalizations.of(context)!;

      if (['1', '2', '3', '4', '5', '6', '7', '8'].contains(message)) {
        final specialties = {
          '1': loc.internalMedicine,
          '2': loc.pediatrics,
          '3': loc.orthopedics,
          '4': loc.dentistry,
          '5': loc.pulmonology,
          '6': loc.cardiology,
          '7': loc.physicalTherapy,
          '8': loc.oBGYN,
        };
        String selected = specialties[message]!;
        messages.add({
          'sender': 'bot',
          'type': 'button',
          'specialty': selected,
          'message': Localizations.localeOf(context).languageCode == 'ar'
              ? "انت اخترت قسم $selected.\nانقر اسفله للمتابعة."
              : "You chose $selected department.\nClick below to continue.",
          'time': time,
        });
      } else {
        String response = _generateBotResponse(message);
        messages.add({'sender': 'bot', 'message': response, 'time': time});
      }
    });

    _controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  final FocusNode _focusNode = FocusNode();

  String _generateBotResponse(String message) {
    final loc = AppLocalizations.of(context)!;
    message = message.toLowerCase();
    if (message.contains(loc.hi) || message.contains(loc.helloo)) {
      return loc.bot_greeting;
    } else if (message.contains(loc.howAreU)) {
      return loc.bot_feeling;
    } else if (message.contains(loc.iAmGood) ||
        message.contains(loc.doingGreat) ||
        message.contains(loc.fine)) {
      return loc.bot_glad_response;
    } else if (message.contains(loc.wantToBook) ||
        message.contains(loc.wantToBookAppoi)) {
      return loc.bot_booking_prompt;
    } else {
      return loc.bot_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.chatBot,
          style: const TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isUser = messages[index]['sender'] == 'user';
                final isButton = messages[index]['type'] == 'button';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                    constraints: BoxConstraints(maxWidth: 250.w),
                    decoration: BoxDecoration(
                      color: isUser ? ColorsManager.blue2 : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                        bottomLeft: isUser
                            ? Radius.circular(12.r)
                            : Radius.circular(0.r),
                        bottomRight: isUser
                            ? Radius.circular(0.r)
                            : Radius.circular(12.r),
                      ),
                    ),
                    child: isButton
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages[index]['message'],
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.black,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Align(
                                alignment: Localizations.localeOf(context)
                                            .languageCode ==
                                        'ar'
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsManager.blue4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                  ),
                                  onPressed: () {
                                    _navigateToSpecialtyScreen(
                                        messages[index]['specialty']);
                                  },
                                  child: Text(
                                    loc.button_view_doctors,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Text(
                            messages[index]['message'],
                            style: GoogleFonts.inter(
                              color: isUser
                                  ? ColorsManager.white
                                  : ColorsManager.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: REdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    focusNode: FocusNode(),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        _sendMessage(value.trim());
                      }
                    },
                    decoration: InputDecoration(
                      hintText: loc.hint_type_message,
                      hintStyle: const TextStyle(color: ColorsManager.hint),
                      contentPadding:
                          REdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorsManager.hint),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: themeProvider.isLightTheme()
                              ? ColorsManager.hint
                              : ColorsManager.lightGray,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon:
                      Icon(Icons.send, size: 24.sp, color: ColorsManager.blue2),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
