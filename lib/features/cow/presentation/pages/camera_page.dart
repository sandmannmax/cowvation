
import 'package:camera/camera.dart';
import 'package:cowvation/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {

  CameraPage({
    Key key
  }) : super(key: key);


  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera, 
      ResolutionPreset.medium
    );
    await _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) return new Scaffold(
      appBar: AppBar(
        title: Text('CowVation - Kamera'),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          LoadingWidget()
        ],
      )
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamera'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[ AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: new CameraPreview(_cameraController),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.camera),
              iconSize: 80,
              onPressed: () async {
                try {
                  final path = join(
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.png',
                  );

                  await _cameraController.takePicture(path);

                  Navigator.pop(context, path);
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
        ]
      ),
    );
  }
}