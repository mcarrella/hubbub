import 'package:flutter/material.dart';
import 'package:hubbub/extensions/context.dart';

class AppColors {
	static const Color indigo = Color(0xFF6C79DB0);
	}
class FabItem {
	const FabItem(this.title, this.icon, {this.onPress});
	
	final IconData icon;
	final Function onPress;
	final String title;
}

class FabMenuItem extends StatelessWidget {
	const FabMenuItem(this.item, {Key key}) : super(key: key);
	
	final FabItem item;
	
	@override
	Widget build(BuildContext context) {
		return MaterialButton(
				shape: StadiumBorder(),
				padding: EdgeInsets.only(top: 8,
										bottom: 8,
										left: 24,
										right: 16),
				color: Colors.white,
				splashColor: Colors.grey.withOpacity(0.1),
				highlightColor: Colors.grey.withOpacity(0.1),
				elevation: 0,
				highlightElevation: 2,
				disabledColor: Colors.white,
				onPressed: item.onPress,
				child: Row(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Text(item.title),
						SizedBox(width: 8),
						Icon(item.icon, color: AppColors.indigo),
						],
					),
				);
		}
}


class ExpandedAnimationFab extends AnimatedWidget {
	const ExpandedAnimationFab({
						@required this.items,
						AnimationController controller,
						this.onPress,
						Key key,
						}) : super(key: key, listenable: controller);
						
	final List<FabItem> items;
	final Function onPress;
	Animation<double> get _animation => listenable;

	
	Animation<double> get animation => listenable;
	
	
	Widget _buildItem(BuildContext context, int index) {
		final screenWidth = context.screenSize.width;
		final transform = Matrix4.translationValues(
							-(screenWidth - animation.value * screenWidth) * ((items.length - index) / 4),
							0.0,
							0.0,
							);
							
		return Align(
					alignment: Alignment.centerRight,
					child: Transform(
										transform: transform,
										child: Opacity(
														opacity: animation.value,
														child: FabMenuItem(items[index]),
														),
											),
							);
		}
		
		
	@override
	Widget build(BuildContext context) {
		return Column(
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.end,
				children: [
							IgnorePointer(
										ignoring: animation.value == 0,
										child: ListView.separated(
														shrinkWrap: true,
														physics: NeverScrollableScrollPhysics(),
														separatorBuilder: (_, __) => SizedBox(height: 9),
														padding: EdgeInsets.symmetric(vertical: 12),
														itemCount: items.length,
														itemBuilder: _buildItem,
														),
											),
							FloatingActionButton(
								backgroundColor: AppColors.indigo,
								child: AnimatedIcon(
										icon: AnimatedIcons.menu_close,
										progress: animation,
										),
								onPressed: onPress,
							),
						],
					);
			}
	}
											

class FabMenu extends StatelessWidget {
	const FabMenu({
		@required this.animation,
		@required this.toggle,
		this.onFavouritePress,
		this.onAllGenPress,
		this.onSearchPress,
		});
		
		
	final AnimationController animation;
	final Function toggle;
	final Function onFavouritePress;
	final Function onAllGenPress;
	final onSearchPress;
	
	void onPress(Function callback) {
		toggle();
		if (callback != null) callback();
	}
	
	@override
	Widget build(BuildContext context) {
		return ExpandedAnimationFab(
			controller: animation,
			onPress: toggle,
			items: [
					FabItem(
								'Favorites',
								Icons.favorite,
								onPress: () => onPress(onFavouritePress),
								),
					FabItem(
								
								'View All',
								Icons.filter_vintage,
								onPress: () => onPress(onAllGenPress),
							),
					FabItem(
								'Search',
								Icons.search,
								onPress: () => onPress(onSearchPress),
								),
							],
					);
				}
}