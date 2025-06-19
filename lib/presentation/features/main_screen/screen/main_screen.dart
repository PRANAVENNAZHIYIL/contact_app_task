import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:houzeo_app/presentation/features/contact_list/screen/contact_list_page.dart';
import 'package:houzeo_app/presentation/features/fav_screen/screen/fav_contact_screen.dart';
import 'package:houzeo_app/presentation/features/main_screen/provider/main_screen_provider.dart';
import 'package:houzeo_app/presentation/features/main_screen/widgets/bottom_nav_animated.dart';
import 'package:houzeo_app/presentation/features/main_screen/widgets/dial_pad_icon.dart';
import 'package:houzeo_app/presentation/features/main_screen/widgets/search_bar_widget.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    const ViewFavoriteContactsScreen(),
    const ViewContactsScreen()
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider =
          Provider.of<MainScreenController>(context, listen: false);
      provider.initiate(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenController>(
      builder: (context, provider, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarColor: backgroundColor,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const SearchBarWidget(),
            body: Consumer<MainScreenController>(
              builder: (context, value, child) {
                return SafeArea(
                  child: screens[value.currentScreenIndex],
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: DialPadIconButton(),
            bottomNavigationBar: CustomCurvedNavigationBar(
              mainModel: provider,
              pageContext: context,
            ),
          ),
        );
      },
    );
  }
}
