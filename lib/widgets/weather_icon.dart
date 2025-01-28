import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class WeatherIcon extends StatelessWidget {
  final String iconUrl;
  final double size;
  const WeatherIcon({super.key, required this.iconUrl, required this.size});

  @override
  Widget build(BuildContext context) {
        String imageUrl = iconUrl;
     if(!iconUrl.startsWith('https:')){
        imageUrl = 'https:$iconUrl';
     }
     return Image.network(
            imageUrl,
             width: size,
             height: size,
              errorBuilder: (context, error, stackTrace) {
                 if (kDebugMode) {
                    print('Error loading image: $error');
                   }
                  return Icon(Icons.image, size: size,);
                },
             );
      }
}