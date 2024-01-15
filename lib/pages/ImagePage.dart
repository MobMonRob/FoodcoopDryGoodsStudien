import 'package:tflite_v2/tflite_v2.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../widgets/listview/ImageResultListView.dart';


enum CameraType {
  primary,
  secondary,
}

extension CameraTypeExtension on CameraType {
  Future<List<CameraDescription>> get cameras async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    if (this == CameraType.primary) {
      return cameras.where((camera) => camera.lensDirection == CameraLensDirection.back).toList();
    } else {
      return cameras.where((camera) => camera.lensDirection == CameraLensDirection.front).toList();
    }
  }
}

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool camera_loading = true;
  bool model_loading = true;
  bool data_available = false;
  List<dynamic> data = [];
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel().then((value){
      setState(() {
        model_loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(model: "assets/model/model_unquant.tflite", labels: "assets/model/labels.txt");
  }

  Future<void> _initializeCamera() async {
    final cameras = await CameraType.primary.cameras;
    final firstCamera = cameras.first;

    _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
        enableAudio: false
    );

    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      camera_loading = false;
    });
  }

  Future<String> _captureImage() async {
    var path = null;
    try {
      _controller.setFlashMode(FlashMode.auto);
      final image = await _controller.takePicture();
      print('Image path: ${image.path}');
      path = image.path;
      _controller.setFlashMode(FlashMode.off);

      if (path !=null) {
        return path;
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
    return path;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> processImage() async {
    final path = await _captureImage();
    if (model_loading) {
      print('Modell lädt');
    } else {
      if (path != null) {
        var recognitions = await Tflite.runModelOnImage(path: path);
        print(recognitions);
        setState(() {
          data_available = true;
          data = recognitions!;
        });
      }
    }

  }

  void _showCameraPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'bitte Bild aufnehmen',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: CameraPreview(_controller),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                data_available = false;
              });
              processImage();
              Navigator.pop(context);
            },
            child: Text(
              'Bild aufnehmen',
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'beenden',
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !data_available ? const Center(
          child: Text('Bitte Bild aufnehmen'),
        ) :
        ImageResultListView(items: data,),
        Positioned(
          bottom: 15,
          right: 15,
          child: FloatingActionButton(
            onPressed: () {

              _showCameraPopup(context);
            },
            child: const Icon(Icons.camera_alt_outlined),
          ),
        )
      ],
    );
  }
}
