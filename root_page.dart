import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:hubbub/cubits/cubits.dart';
import 'package:hubbub/pages/pages.dart';
import 'package:hubbub/pages/home_page.dart';




import 'package:hubbub/widgets/widgets.dart';

class RootWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
						body: SafeArea(
								child: CubitConsumer<AuthCubit, AuthState>(
									builder: (context, state) {
														if (state is AuthSuccess) { return Welcome(); }
														else { return AuthPage(); }
										},
									

									listener: (context, state) {
														if (state is AuthLoading) {
																return LoadingWidget();
															}
														if (state is AuthError) {
																	Scaffold.of(context).showSnackBar(
		
																			SnackBar(
																					content: Text(
																									state.message,
																									style: Theme.of(context)
																													.textTheme
																													.caption
																													.copyWith(color: Colors.white, fontSize: 16.0),
																								),
																						),
				);
															}
									
													},
									
							),
						),
				);
		}

	}
