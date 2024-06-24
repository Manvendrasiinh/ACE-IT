import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:ace_it/providers/flash_card_provider.dart';
import 'package:ace_it/widgets/background_container_widget.dart';
import 'package:share_plus/share_plus.dart';

class FlashCardScreen extends StatelessWidget {
  final String name;
  final String category;
  final String type;

  const FlashCardScreen({
    required this.name,
    required this.type,
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashCardProvider(),
      child: FlashCardScreenContent(
        name: name,
        type: type,
        category: category,
      ),
    );
  }
}

class FlashCardScreenContent extends StatelessWidget {
  final String name;
  final String category;
  final String type;

  const FlashCardScreenContent({super.key,
    required this.name,
    required this.type,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BackgroundContainerWidget(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FutureBuilder(
              future: Provider.of<FlashCardProvider>(context, listen: false)
                  .fetchQuestions(
                name: name,
                type: type,
                category: category,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.black54,));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return Consumer<FlashCardProvider>(
                  builder: (context, provider, child) {
                    if (provider.cards.isEmpty) {
                      return const Center(child: Text('No flashcards available.'));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  Text(
                                    'Progress: ${provider.progress} / ${provider.cards.length}',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: const Text('Reset Progress'),
                                        content: const Text('Are you sure, you want to reset progress?'),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No'),
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              provider.resetProgress();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.rotate_right, size: 50.r),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        const Expanded(
                          child: FlipCardWidget(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                          child: GestureDetector(
                            onTap: (){
                              Share.share("*$name interview related question.*\n\n*${provider.cards[provider.progress]['que']}*\n\n${provider.cards[provider.progress]['ans']}", subject: 'Hey! You should read this concept for interview.');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share_outlined, size: 15.h),
                                SizedBox(width: 10.w,),
                                Text('Share this concept with your friends.', style: theme.textTheme.bodySmall,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FlipCardWidget extends StatefulWidget {
  const FlipCardWidget({super.key});

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  final FlipCardController flipController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashCardProvider>(context);
    final theme = Theme.of(context);

    return FlipCard(
      controller: flipController,
      onTapFlipping: true,
      frontWidget: glassContainer(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    provider.toggleBookmark(provider.cards[provider.progress]['que'], provider.cards[provider.progress]['ans']);
                  },
                    child: Icon(
                      provider.isBookmarked(provider.cards[provider.progress]['que'])
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      size: 50.h,
                      color: Colors.black.withOpacity(0.7)
                    ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.r),
                  child: Text(
                    'QUESTION',
                    style:
                    theme.textTheme.bodyMedium!.copyWith(letterSpacing: 2),
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.r),
                  child: Consumer<FlashCardProvider>(
                    builder: (context, provider, child) => Text(
                      provider.cards[provider.progress]['que'],
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 45.h,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      provider.nextQuestion();
                    },
                    child: Text(
                      "I know this concept",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                SizedBox(height: 15.r),
                SizedBox(
                  height: 45.h,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      flipController.flipcard();
                    },
                    child: Text(
                      "I don’t know this concept",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backWidget: glassContainer(
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.bookmark_outline, size: 50.h),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.r),
                    child: Text(
                      'SOLUTION',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(letterSpacing: 2),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.r),
                    child: Consumer<FlashCardProvider>(
                      builder: (context, provider, child) => Text(
                        provider.cards[provider.progress]['ans'],
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    flipController.flipcard().then((onValue) => provider.nextQuestion());
                  },
                  child: Text(
                    "See next concept",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          )),
      rotateSide: RotateSide.right,
    );
  }

  Widget glassContainer(context, child) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(30.r),
        opacity: 0.5,
        shadowStrength: 4,
        shadowColor: Colors.black45,
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: child,
        ),
      ),
    );
  }
}