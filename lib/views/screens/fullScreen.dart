import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class Fullscreen extends StatelessWidget {
  final String imgUrl;

  Fullscreen({Key? key, required this.imgUrl}) : super(key: key);
  

  // Function to request storage permissions
  Future<bool> _requestPermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  // Function to download and open the image
  Future<void> downloadAndOpenImage(String imageUrl, BuildContext context) async {
    // Request storage permission before attempting to download
    bool permissionGranted = await _requestPermission();

    if (!permissionGranted) {
      // Show a SnackBar if the permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    // Show SnackBar to notify user that the download is starting
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Downloading started...")),
    );

    try {
      // Download the image and get the saved image id
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null) {
        return;
      }

      // Get the file path of the downloaded image
      var filePath = await ImageDownloader.findPath(imageId);

      // Check if the widget is still mounted before using the context
      if (!context.mounted) return;

      // Show SnackBar with an action button to open the image
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Download successful"),
        action: SnackBarAction(
          label: "Open",
          onPressed: () {
            if (filePath != null) {
              OpenFile.open(filePath); // Open the downloaded image
            }
          },
        ),
      ));
    } on PlatformException catch (e) {
      // Handle download error and show a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          // Start the download process when button is pressed
          await downloadAndOpenImage(imgUrl, context);
        },
        child: const Text("Download Wallpaper"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
