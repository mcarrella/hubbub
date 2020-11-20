import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';


import 'package:hubbub/cubits/auth/auth.dart';

import 'package:hubbub/widgets/widgets.dart';


class AuthPage extends StatefulWidget {
	@override
	_AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
	
	PageController _controller = PageController();
	
	String _username = '';
	String _email = '';
	String _password = '';
	
	
	_buildLogo(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Column(children: [
          SvgPicture.asset(
            'assets/logo.svg',
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
                text: 'huB',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: 'ub',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ]),
          )
        ]),
      );
	
	List<Widget> _emailAndPassword() => [
			CustomTextField(
					hint: 'email',
					fontSize: 18.0,
					fontWeight: FontWeight.normal,
					onChanged: (val) {
						_email = val;
						},
					),
			SizedBox(height: 30.0),
			CustomTextField(
					hint: 'password',
					fontSize: 18.0,
					fontWeight: FontWeight.normal,
					onChanged: (val) {
						_password = val;
					},
				)
			];
	
	_signUp() => Padding(
		padding: const EdgeInsets.symmetric(horizontal: 24.0),
		child: Column(
			children: [
				CustomTextField(
					hint: 'username',
					fontSize: 18.0,
					fontWeight: FontWeight.normal,
					onChanged: (val) {
						_username = val;
					},
				),
			SizedBox(height: 30.0),
			..._emailAndPassword(),
			SizedBox(height: 30.0),
			CustomFlatButton(
				text: 'sign up',
				size: Size(double.infinity, 54.0),
				onPressed: () {
					
					CubitProvider.of<AuthCubit>(context)
								.signUp(_email, _password);
							},
					),
					
			SizedBox(height: 30.0),
			SizedBox(height: 30.0),
			RichText(
				text: TextSpan(
					text: 'already have an account?',
					style: Theme.of(context).textTheme.caption.copyWith(
								color: Colors.black,
								fontSize: 18.0,
								fontWeight: FontWeight.normal,
								),
							children: [
							TextSpan(
								text: 'sign in',
								style: TextStyle(
									color: Theme.of(context).accentColor,
									fontSize: 18.0,
									fontWeight: FontWeight.bold,
									),
									
								
							recognizer: TapGestureRecognizer()
								..onTap = () {
									_controller.previousPage(
										duration: Duration(milliseconds: 1000),
										curve: Curves.elasticOut);
									},
								)
							],
						),
					)
				],
			),
	);
			
	
	_signIn() => Padding(
						padding: const EdgeInsets.symmetric(horizontal: 24.0),
						child: Column(
							children: [
											..._emailAndPassword(),
											SizedBox(height: 30.0),
											CustomFlatButton(
												text: 'sign in',
												size: Size(double.infinity, 54.0),
												onPressed: () {
													CubitProvider.of<AuthCubit>(context).signInWithEmailAndPassword(
																		_email,
																		_password
																		
																
																);
															},
														),
											SizedBox(height:30.0),
											CustomOutlineButton(
												text: 'sign in with google',
												size: Size(double.infinity, 50.0),
												icon: SvgPicture.asset(
														'assets/google-icon.svg',
														height: 18.0,
														width: 18.0,
														fit: BoxFit.fill,
														),
												onPressed: () {
																	CubitProvider.of<AuthCubit>(context)
																			.signInWithGoogle();
																			
																		},
																),
											SizedBox(height: 30.0),
											RichText(
												text: TextSpan(
														text: 'dont have an account?',
														style: Theme.of(context).textTheme.caption.copyWith(
																color: Colors.black,
																fontSize: 18.0,
																fontWeight: FontWeight.normal,
																),
												children: [
																TextSpan(
																	text: 'sign up',
																	style: TextStyle(
																			color: Theme.of(context).accentColor,
																			fontSize: 18.0,
																			fontWeight: FontWeight.bold,
																			),
																	recognizer: TapGestureRecognizer()
																					..onTap = () {
																						_controller.nextPage(
																								duration: Duration(milliseconds: 1000),
																								curve: Curves.elasticOut);
																								},
																							)
																						],
																					),
																				)
																			],
																		),
																		
																	);
	
	@override
	Widget build(BuildContext context) {
		 return Column(
					mainAxisAlignment: MainAxisAlignment.start,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
								Padding(
									padding: const EdgeInsets.only(top: 110.0),
									child: _buildLogo(context),
									),
								SizedBox(height: 50.0),
								Expanded(
											child: PageView(
												physics: NeverScrollableScrollPhysics(),
												controller: _controller,
												children: [
																_signIn(),
																_signUp(),
																],
													),
										),
								],
							);
						}
}