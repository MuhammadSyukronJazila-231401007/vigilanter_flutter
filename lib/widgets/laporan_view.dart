import 'package:flutter/material.dart';
import 'package:vigilanter_flutter/widgets/laporan_card.dart';


class LaporanView extends StatelessWidget {
  const LaporanView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.04
      ),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return LaporanCard();
        },
      ),
        // builder: (context, constraints) {
        //   int crossAxisCount;
        //   double childAspectRatio;
        //
        //   if (constraints.maxWidth < 600) {
        //     crossAxisCount = 3;
        //     childAspectRatio = 0.55;
        //   } else if (constraints.maxWidth < 900) {
        //     crossAxisCount = 5;
        //     childAspectRatio = 0.6;
        //   } else {
        //     crossAxisCount = (constraints.maxWidth / 200).floor().clamp(4, 6);
        //     childAspectRatio = 0.8;
        //   }
        //
        //   return GridView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: crossAxisCount,
        //       mainAxisSpacing: constraints.maxWidth * 0.03,
        //       crossAxisSpacing: constraints.maxWidth * 0.05,
        //       childAspectRatio: childAspectRatio,
        //     ),
        //
        //     itemBuilder: (context, index) {
        //       return LaporanCard();
        //     },
        //   );
        // },

    );
  }
}