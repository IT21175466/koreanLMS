import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';

class BatchTile extends StatefulWidget {
  final String batchName;
  final bool isLock;
  const BatchTile({super.key, required this.batchName, required this.isLock});

  @override
  State<BatchTile> createState() => _BatchTileState();
}

class _BatchTileState extends State<BatchTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 135,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: widget.isLock ? Colors.black.withOpacity(0.4) : Colors.white,
        border: Border.all(
          color: AppColors.orangeColor,
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            widget.batchName,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: AppColors.accentColor,
              fontSize: 18,
            ),
          ),
          Spacer(),
          widget.isLock
              ? Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 20,
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.accentColor,
                  size: 15,
                )
        ],
      ),
    );
  }
}
