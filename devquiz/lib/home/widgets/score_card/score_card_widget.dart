import 'package:flutter/material.dart';

import 'package:devquiz/core/core.dart';
import 'package:devquiz/home/widgets/chart/chart_widget.dart';

class ScoreCardWidget extends StatelessWidget {
  final double percentage;
  
  const ScoreCardWidget({
    Key? key,
    required this.percentage,
  }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 20),
			child: Container(
				height: 136,
				decoration: BoxDecoration(
					color: AppColors.white,
					borderRadius: BorderRadius.circular(15)
				),
				child: Padding(
				  padding: const EdgeInsets.symmetric(horizontal: 24),
				  child: Row(
				  	crossAxisAlignment: CrossAxisAlignment.center,
				  	children: [
				  		Expanded(
				  			flex: 2,
				  			child: ChartWidget(
                  percentage: percentage,
                ),
				  		),
				  		Expanded(
				  			flex: 4,
				  			child: Padding(
				  				padding: const EdgeInsets.only(left: 24),
				  				child: Column(
				  					mainAxisAlignment: MainAxisAlignment.center,
				  					crossAxisAlignment: CrossAxisAlignment.start,
				  					children: [
				  						Text("Vamos começar", style: AppTextStyles.heading,),
				  						Text("Complete os desafios e avance em conhecimento", style: AppTextStyles.body),
				  					],
				  				),
				  			),
				  		),
				  	],
				  ),
				),
			),
		);
	}
}
