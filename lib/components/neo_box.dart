
import 'package:flutter/material.dart';

class NeoBox extends StatelessWidget {
  final Widget? child;
  const NeoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          //darker shadow on box
          BoxShadow(
            blurRadius: 15,
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
          ),

          // lighter shadow on box

           BoxShadow(
            blurRadius: 15,
            color: Colors.white, 
            offset: const Offset(-4, -4),
            ),

        ]

      ),
      padding: EdgeInsets.all(5),
      child: child,


    );
  }
}