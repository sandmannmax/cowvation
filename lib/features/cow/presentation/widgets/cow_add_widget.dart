import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cowvation/features/cow/presentation/bloc_add/cow_add_bloc.dart';
import 'package:cowvation/features/cow/presentation/pages/camera_page.dart';
import 'package:cowvation/features/cow/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CowAddWidget extends StatefulWidget {
  const CowAddWidget({
    Key key,
  }) : super(key: key);

  @override
  _CowAddWidgetState createState() => _CowAddWidgetState();
}

class _CowAddWidgetState extends State<CowAddWidget> {
  String _number;
  String _earNumber;
  String _race;
  String _colorTendency;
  String _height;
  bool _fetch = false;
  bool _manual = false;
  String _group;
  String _imageOne;
  String _imageTwo;
  String _imageThree;

  List l = [0];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlay: false,
          ),
          items: l.map((value) {
            if (value == 0) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            iconSize: 50,
                            icon: Icon(Icons.add_circle),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraPage()));
                              if (result != null) {
                                setState(() {
                                  switch (l.length) {
                                    case 1:
                                    {
                                      _imageOne = result;
                                      break;
                                    }
                                    case 2:
                                    {
                                      _imageTwo = result;
                                      break;
                                    }
                                    case 3:
                                    {
                                      _imageThree = result;
                                      break;
                                    }
                                  }
                                  l.insert(l.length - 1, result);
                                  if (l.length == 4) {
                                    l.removeLast();
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ));
                },
              );
            } else {
              return Image.file(File(value));
            }
          }).toList(),
        ),
        Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              InputWidget(
                  params: _buildParams(descriptions: [
                'Kuhnummer',
                'Ohrnummer',
                'Rasse'
              ], onChanges: [
                (text) {
                  _number = text;
                },
                (text) {
                  _earNumber = text;
                },
                (text) {
                  _race = text;
                }
              ])),
              InputWidget(
                  params: _buildParams(descriptions: [
                'Farbtendenz',
                'Größe'
              ], onChanges: [
                (text) {
                  _colorTendency = text;
                },
                (text) {
                  _height = text;
                }
              ])),
              Row(
                children: <Widget>[
                  Expanded(
                      child: CheckboxListTile(
                    title: Text('Handkuh'),
                    onChanged: (bool value) {
                      setState(() {
                        _manual = value;
                      });
                    },
                    value: _manual,
                    activeColor: Theme.of(context).accentColor,
                  )),
                  Expanded(
                      child: CheckboxListTile(
                    title: Text('Holkuh'),
                    onChanged: (bool value) {
                      setState(() {
                        _fetch = value;
                      });
                    },
                    value: _fetch,
                    activeColor: Theme.of(context).accentColor,
                  )),
                ],
              ),
              InputWidget(
                  params: _buildParams(descriptions: [
                'Gruppe'
              ], onChanges: [
                (text) {
                  _group = text;
                }
              ])),
              RaisedButton(
                child: Text('Hinzufügen'),
                onPressed: sendCow,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Params> _buildParams(
      {@required List<String> descriptions,
      @required List<dynamic> onChanges}) {
    List<Params> params = List<Params>();
    for (var i = 0; i < descriptions.length; i++) {
      params.add(
        Params(
          description: descriptions[i],
          onChange: onChanges[i],
        ),
      );
    }
    return params;
  }

  void sendCow() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<CowAddBloc>(context).add(CowAddE(
        cowNumber: int.parse(_number),
        numberEar: int.parse(_earNumber),
        race: _race,
        colorTendency: _colorTendency,
        height: _height,
        fetch: _fetch,
        manual: _manual,
        group: _group,
        imageOne: _imageOne,
        imageTwo: _imageTwo,
        imageThree: _imageThree,
      ));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
