import 'package:flutter/material.dart';

class LaporanCard extends StatelessWidget {

  const LaporanCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => {
        //TODO: Navigate to detail laporan
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;

          return Container(
            width: cardWidth,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
              color: Color(0xFF0D1234)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.masks_outlined, size: screenWidth * 0.05,),
                    SizedBox(width: screenWidth * 0.01,),
                    Text(
                      'Begal Motor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                 Divider(
                   color: Color(0xFF4C4E6966).withValues(alpha: 0.4),
                   height: 5,
                   thickness: 1,
                   indent: 16,
                   endIndent: 16,
                 ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, size: screenWidth * 0.035,),
                            SizedBox(width: screenWidth * 0.01,),
                            Text(
                              "Simpang Tiga Kampus USU",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.035,
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: screenWidth * 0.035,),
                            SizedBox(width: screenWidth * 0.01,),
                            Text(
                              "Jumat, 21 Juni 2024 (21:03:21 WIB)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.035,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            color: Colors.red
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.not_interested),
                              Text(
                                'Batalkan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035
                                ),
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),


          ],
            ),
          );
        },
      ),
    );

  }
}