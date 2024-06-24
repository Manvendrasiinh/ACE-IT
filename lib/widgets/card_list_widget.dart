import 'package:ace_it/providers/card_selected_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import '../../../../models/card_model.dart';

class CardListWidget extends StatelessWidget {
  final List<CardModel> cards;

  const CardListWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Consumer<CardSelectedProvider>(
      builder: (context, cardSelectedProvider, child) {
        return Wrap(
          spacing: 5.r,
          runSpacing: 5.r,
          children: cards.map((card) {
            bool isSelected = cardSelectedProvider.selectedCardName == card.name;
            return Padding(
              padding: EdgeInsets.only(top: 5.h, right: 3.h),
              child: GestureDetector(
                onTap: () {
                  Provider.of<CardSelectedProvider>(context, listen: false)
                      .onCardSelected(name: card.name, type: card.type, category: card.category, context:  context);
                },
                child: GlassContainer(
                  border: isSelected ? Border.all() : null,
                  opacity: 0.5,
                  color: isSelected ? Colors.white70 : null,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 8.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.r,
                          child: CachedNetworkImage(
                            imageUrl: card.logo,
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                            placeholder: (context, url) =>
                                Icon(Icons.circle_outlined, size: 15.r),
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          card.name,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
