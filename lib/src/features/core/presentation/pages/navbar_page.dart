import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../mail_box/presentation/pages/mailbox_request_page.dart';
import '../cubits/user_cubit/user_cubit.dart';
import '../widgets/navigation_bar_widget.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int activeIndex =0;


  final List<dynamic> _icons = [
    Icons.home_outlined,
    Icons.mail,
    // Icons.groups,
    // Icons.language_outlined,
    // Icons.list,
  ];
  final List<Widget> _widgets = [
    const HomePage(),
    const MailBoxRequestPage(),
    // const UsersPage(),
    // LanguagesPage(),
    // CategoriesPage(),
  ];

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context,navbarSetState) {
        return

          Scaffold(
              drawerScrimColor:Colors.transparent,//For not shadow in back drawer
          appBar: AppBar(

            elevation: 0.0,
            leadingWidth: 60,
            title: const Padding(
              padding: EdgeInsets.all(AppPadding.p6),
              child:Text('PTC'),
            ),
            leading:Hero(
              tag: 'location-image-${AssetsManager.logoIMG}',
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Image.asset(AssetsManager.logoIMG),
              ),
            ),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    context.read<UserCubit>().logout(context);
                  },
                icon: const Icon(Icons.logout),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(color: ColorManager.primary),
                  ),)
            ],
          ),



          body: _widgets[activeIndex],
            extendBody: true,
           // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar:
          NavigationBarWidget(
            activeIndex:activeIndex,
            icons: _icons,
            onTap: (index) {
              setState(() {
                activeIndex = index;
              });

            },
          )
          // BottomAppBar(
          //
          //   shape: CircularNotchedRectangle(),
          //   notchMargin: 12,
          //   // color: Colors.blue,
          //   child: BottomNavigationBar(
          //     backgroundColor:Colors.transparent,
          //       elevation:0,
          //     items: [
          //       BottomNavigationBarItem(icon: Icon(Icons.add),label: ''),
          //       BottomNavigationBarItem(icon: Icon(Icons.add),label: ''),
          //        BottomNavigationBarItem(icon: Icon(Icons.add),label: ''),
          //
          //     ],
          //
          //   ),
          //
          // ),



        );
      }
    );
  }
}
