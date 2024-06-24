import 'package:ace_it/screens/bookmarks_screen.dart';
import 'package:ace_it/screens/flash_card_screen.dart';
import 'package:ace_it/widgets/background_container_widget.dart';
import 'package:ace_it/widgets/category_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/card_selected_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BackgroundContainerWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Practice Cards',
                        style: theme.textTheme.titleLarge,
                      ),
                      GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BookmarksScreen()));
                      }, child: Icon(Icons.bookmark_outline, size: 50.r, color: Colors.black87,)),
                    ],
                  ),
                  // SizedBox(height: 5.h),
                  category('Programming Languages', context),
                  category('Mobile App Development', context),
                  category('Web App Development', context),
                  category('Databases', context),
                  category('Miscellaneous', context),
                  // Consumer<CardSelectedProvider>(
                  //   builder: (context, provider, child) {
                  //     if (provider.isCardSelected) {
                  //       return Padding(
                  //         padding:
                  //             EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  //         child: performAction(
                  //           context,
                  //           name: provider.selectedCardName,
                  //           category: provider.selectedCardCategory,
                  //           type: provider.selectedCardType,
                  //         ),
                  //       );
                  //     }
                  //     return const SizedBox.shrink();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget category(String name, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        CategoryBuilderWidget(name: name),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Widget performAction(context,
  //     {required String name,
  //     required String category,
  //     required String type}) {
  //   return GestureDetector(
  //     onTap: () {
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) => FlashCardScreen(
  //                   name: name,
  //                   category: category,
  //                   type: type,
  //                 )));
  //     },
  //     child: Container(
  //       height: 45.h,
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [
  //             const Color(0xFFFFB0E3).withOpacity(0.9),
  //             const Color(0xFFFFFFFF).withOpacity(0.9),
  //             const Color(0xFF94FFD8).withOpacity(0.9),
  //           ],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //         borderRadius: BorderRadius.circular(20.r),
  //         border: Border.all()
  //       ),
  //       child: Center(
  //         child: Text(
  //           "Ace Your $name",
  //           style: Theme.of(context).textTheme.bodyMedium,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
