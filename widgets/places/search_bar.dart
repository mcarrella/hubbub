import 'package:flutter/material.dart';



class SearchBar extends StatelessWidget {
	const SearchBar({
			this.margin = const EdgeInsets.symmetric(horizontal: 28),
			});
			
	final EdgeInsets margin;
	
	@override
	Widget build(BuildContext context) {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 18),
			margin: margin,
			decoration: ShapeDecoration(
				shape: StadiumBorder(),
				color: Theme.of(context).scaffoldBackgroundColor,
				),
			child: Row(
				mainAxisSize: MainAxisSize.max,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					Icon(Icons.search),
					SizedBox(width: 13),
					Expanded(
						child: TextFormField(
								decoration: InputDecoration(
									hintText: 'search here',
									hintStyle: TextStyle(
										fontSize: 14,
										color: Colors.grey,
										),
								border: InputBorder.none,
								),
							),
						),
					],
				),
			);
		}
}