import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';


class WeatherSkeleton extends StatelessWidget {
  const WeatherSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
       enabled: true,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
           children: [
           const Card(
                 child: SizedBox(width: double.infinity, height: 200),
               ),
               const SizedBox(height: 10),
               Text("", style: TextStyle(fontSize: 15),),
               Align(
                  alignment: Alignment.centerLeft,
                   child: const Padding(
                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: SizedBox(width: 100, height: 20),
                   ),
                  ),
                SizedBox(
                    height: 150,
                  child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                    itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                         child: const Card(
                          child: SizedBox(width: 110, height: 130),
                         ),
                      );
                   }
               ),
               ),
           ],
       ),
      )
    );
  }
}