import 'package:flutter/material.dart';
import 'package:hubbub/widgets/widgets.dart';
import 'modal.dart';


class SearchBottomModal extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final viewInsets = MediaQuery.of(context).viewInsets.bottom + 14;
		return Modal(
			child: Column(
				children: <Widget>[
					Padding(
						padding: EdgeInsets.symmetric(
														horizontal: 26,
															vertical: 14),
						child: SearchBar(margin: EdgeInsets.all(0)),
					),
					SizedBox(height: viewInsets),
					],
				),
			);
	}
}