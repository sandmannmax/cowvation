import 'package:cowvation/features/home/home_page.dart';
import 'package:cowvation/features/login/presentation/bloc/token_bloc.dart';
import 'package:cowvation/features/login/presentation/widgets/login_control_widget.dart';
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
      appBar: AppBar(
        title: Text('CowVation - Login'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<TokenBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TokenBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            LoginControl(),
            SizedBox(height: 10),
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
                        MaterialPageRoute(builder: (context) => HomePage())
                      );
                  });
                  return MessageDisplay(message: '');
                }
                return MessageDisplay(message: '');
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }


}
