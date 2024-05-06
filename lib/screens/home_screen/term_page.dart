import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/screens/home_screen/term_papers_tab.dart';
import 'package:koreanlms/screens/home_screen/term_videos_tab.dart';

class TermPage extends StatefulWidget {
  final String batchName;
  final String className;
  final String classID;
  final String termName;
  final String termID;
  const TermPage({
    super.key,
    required this.batchName,
    required this.className,
    required this.classID,
    required this.termID,
    required this.termName,
  });

  @override
  State<TermPage> createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '${widget.termName} Term',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColors.orangeColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(
                      text: "Videos",
                    ),
                    Tab(
                      text: "Papers",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    TermVideosTab(
                      batchName: widget.batchName,
                      className: widget.className,
                      classID: widget.classID,
                      termID: widget.termID,
                      termName: widget.termName,
                    ),
                    TermPapersTab(
                      batchName: widget.batchName,
                      className: widget.className,
                      classID: widget.classID,
                      termID: widget.termID,
                      termName: widget.termName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
