// lib/pages/video_list_page.dart

import 'package:dr_ashraf_clinic/controller/videos_controller.dart';
import 'package:dr_ashraf_clinic/utils/constants/colors.dart';
import 'package:dr_ashraf_clinic/view/home_page/widget/facebook_video_embeder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacebookvideoWidget extends StatelessWidget {
  // Add a boolean parameter to choose between showing all or the last two videos.
  final bool showAllVideos;
  final bool desktopView;
  const FacebookvideoWidget({
    super.key,
    this.showAllVideos = true,
    required this.desktopView,
  });

  @override
  Widget build(BuildContext context) {
    final VideoController videoController = Get.find<VideoController>();
    final ScrollController scrollController = ScrollController();

    return Obx(() {
      if (videoController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (videoController.errorMessage.value != null) {
        return Center(
          child: Text(
            'Error: ${videoController.errorMessage.value}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        );
      } else if (videoController.videos.isEmpty) {
        return const Center(
          child: Text(
            'No videos found.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      } else {
        // Determine the number of videos to show
        final int itemCount = showAllVideos
            ? videoController.videos.length
            : (videoController.videos.length > 2
                  ? 2
                  : videoController.videos.length);

        // Sort videos by creation date in descending order to get the latest.
        final sortedVideos = List.from(videoController.videos)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return desktopView
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                padding: const EdgeInsets.all(16.0),
                controller: scrollController,
                itemCount: itemCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final video = sortedVideos[index];
                  return Card(
                    margin: const EdgeInsets.all(20),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              video.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: HColors.textTitle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (video.videoLink.isNotEmpty)
                            Expanded(
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  height: video.height,
                                  width: video.width,
                                  child: FacebookVideoEmbedder(
                                    scrollController: scrollController,
                                    height: video.height,
                                    videoUrl: video.videoLink,
                                    uniqueId: video.id.toString(),
                                  ),
                                ),
                              ),
                            ),
                          if (video.videoLink.isEmpty)
                            const Text(
                              'No video link available.',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                controller: scrollController,
                itemCount: itemCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final video = sortedVideos[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              video.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: HColors.textTitle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (video.videoLink.isNotEmpty)
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                clipBehavior: Clip.hardEdge,
                                height: video.height,
                                width: video.width,
                                child: FacebookVideoEmbedder(
                                  scrollController: scrollController,
                                  height: video.height,
                                  videoUrl: video.videoLink,
                                  uniqueId: video.id.toString(),
                                ),
                              ),
                            ),
                          if (video.videoLink.isEmpty)
                            const Text(
                              'No video link available.',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }
    });
  }
}
