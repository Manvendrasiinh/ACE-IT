import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import 'package:ace_it/providers/bookmark_provider.dart';
import 'package:ace_it/widgets/background_container_widget.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<BookmarkProvider>(context, listen: false);

    // Fetch bookmarks once when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchBookmarks();
    });

    return Scaffold(
      body: BackgroundContainerWidget(
        child: SafeArea(
          child: Consumer<BookmarkProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: provider.bookmarks.isEmpty
                    ? const Center(child: Text('No bookmarks found.'))
                    : SingleChildScrollView(
                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                      SizedBox(height: 15.h),
                      Text(
                        'Bookmarks',
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        'Total Questions: ${provider.bookmarks.length.toString().padLeft(2, '0')}', // Padded total count
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 15.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.bookmarks.length,
                        itemBuilder: (context, index) {
                          final bookmark = provider.bookmarks[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: GlassContainer(
                              opacity: 0.45,
                              borderRadius: BorderRadius.circular(20.r),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 15.r),
                                  leading: Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Text('${index+1}', style: theme.textTheme.bodyMedium,),
                                  ),
                                  title: Text(
                                    bookmark['que'],
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  trailing: Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15.w, bottom: 10.h, right: 15.w),
                                      child: Text(
                                        bookmark['ans'],
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                                        ],
                                      ),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
