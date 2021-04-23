import 'package:flutter/material.dart';

import 'package:devquiz/challenge/widget/answer/answer_widget.dart';
import 'package:devquiz/core/app_text_styles.dart';
import 'package:devquiz/shared/models/question_model.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onSelect;

  const QuizWidget({
    Key? key,
    required this.question,
    required this.onSelect,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int indexSelected = -1;

  answers() => widget.question.answers;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.question.title,
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          for (var i = 0; i < answers().length; i++)
            AnswerWidget(
              answer: answers()[i],
              isSelected: indexSelected == i,
              disabled: indexSelected != -1,
              onTap: (value) {
                indexSelected = i;
                setState(() {});
                widget.onSelect(value);
              },
            )
        ],
      ),
    );
  }
}
