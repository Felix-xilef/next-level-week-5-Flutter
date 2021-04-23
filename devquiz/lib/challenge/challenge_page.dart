import 'package:flutter/material.dart';

import 'package:devquiz/challenge/challenge_controller.dart';
import 'package:devquiz/challenge/widget/next_button/next_button_widget.dart';
import 'package:devquiz/challenge/widget/question_indicator/question_indicator.dart';
import 'package:devquiz/challenge/widget/quiz/quiz_widget.dart';
import 'package:devquiz/result/result_page.dart';
import 'package:devquiz/shared/models/question_model.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  const ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  Future<void> nextPage() async {
    await pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
    controller.answered = false;
  }

  Future<void> resultPage() async {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => ResultPage(
        title: widget.title,
        length: widget.questions.length,
        result: controller.numberRightAnswers,
      )
    ));
  }

  void onSelect(bool value) {
    if (value) controller.numberRightAnswers++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(104),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions.map((e) => QuizWidget(
          question: e,
          onSelect: (value) {
            controller.answered = true;
            onSelect(value);
          },
        )).toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: controller.answeredNotifier,
                  builder: (context, value, _) {
                    bool lastPage = controller.currentPage == widget.questions.length;
                    if (value == true) {
                      if (lastPage) {
                        return NextButtonWidget.green(
                          label: "Confirmar",
                          onTap: resultPage,
                        );
                      } else {
                        return NextButtonWidget.green(
                          label: "Próxima",
                          onTap: nextPage,
                        );
                      }
                    } else {
                      return NextButtonWidget.white(
                        label: "Pular",
                        onTap: lastPage ? resultPage : nextPage,
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
