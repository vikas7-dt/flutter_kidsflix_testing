import 'package:flutter/material.dart';
import 'package:kidsflix_flutter/util/image_constatnts.dart';
import 'package:shimmer/shimmer.dart';

class AppImage extends StatefulWidget {

  String url;
  BoxFit? fit;

  AppImage(this.url,{super.key,this.fit});

  @override
  State<AppImage> createState() => _AppImageState();

}

class _AppImageState extends State<AppImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      loadingBuilder: (context,child,progress){
        if(progress == null){
            return child;
        }else{
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                period: const Duration(milliseconds: 500),
              child: child,
            );
        }
      },
      errorBuilder: (context,obj,stk){
        return Container(
          child: Image.asset(ImageConstants.hor_placeholder,fit: BoxFit.contain,),
        );
      },
      fit: widget.fit,
    );
  }
}
