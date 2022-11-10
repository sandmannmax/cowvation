import 'package:cowvation/features/home/home_page.dart';
import 'package:cowvation/features/login/bloc/token_bloc.dart';
import 'package:cowvation/features/login/widgets/login_control_widget.dart';
import 'package:cowvation/core/widgets/message_display_widget.dart';
import 'package:cowvation/core/widgets/loading_widget.dart';
import 'package:cowvation/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<TokenBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TokenBloc>(),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30
              ),
              Expanded(
                child: Image(
                  image: AssetImage('assets/cowvationLogo.png'),
                  width: 150,
                ),
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              LoginControl(),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 40,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    BlocBuilder<TokenBloc, TokenState>(
                      builder: (context, state) {
                        if (state is Empty) {
                          return MessageDisplay(message: '');
                        } else if (state is Error) {
                          return MessageDisplay(message: state.message);
                        } else if (state is Loading) {
                          return LoadingWidget();
                        } else if (state is Loaded) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          });
                          return MessageDisplay(message: '');
                        }
                        return MessageDisplay(message: '');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 0,
                  width: 0,
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 40,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/xandmediaLogo.png'),
                  width: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'xandmedia',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
