import 'package:carousel_slider/carousel_slider.dart';
import 'package:cowvation/features/cow/presentation/bloc/cow_bloc.dart';
import 'package:cowvation/features/cow/presentation/widgets/cow_widget.dart';
import 'package:cowvation/features/cow/presentation/widgets/load_control.dart';
import 'package:cowvation/core/widgets/loading_widget.dart';
import 'package:cowvation/core/widgets/message_display_widget.dart';
import 'package:cowvation/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CowPage extends StatelessWidget {
  final int cowNumber;

  CowPage({ @required this.cowNumber }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CowVation - Kuh'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<CowBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CowBloc>(),
      child: Column(
        children: <Widget>[
          LoadControl(cowNumber: this.cowNumber),
          BlocBuilder<CowBloc, CowState>(
            builder: (context, state) {
              if (state is Error) {
                return MessageDisplay(message: state.message);
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                BlocProvider.of<CowBloc>(context).add(LoadImagesE(state.cow));
                return Column(
                  children: <Widget>[
                    Container(
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          LoadingWidget(),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    CowWidget(
                      cow: state.cow
                    ),
                  ]
                );
              } else if (state is LoadedImages) {
                dynamic carousel;
                if (state.imageFiles.length == 0) {
                  carousel = Placeholder(
                    fallbackHeight: MediaQuery.of(context).size.height / 3
                  );
                } else {
                  carousel = CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 3,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                    ),
                    items: state.imageFiles.map((file) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300
                            ),
                            child: Image.file(file)
                          );
                        },
                      );
                    }).toList(),
                  );
                }                
                return Column(
                  children: <Widget>[
                    carousel,
                    CowWidget(
                      cow: state.cow
                    ),
                  ]
                );
              }
              return MessageDisplay(message: 'else');
            },
          ),
        ],
      ),
    );
  }
}
