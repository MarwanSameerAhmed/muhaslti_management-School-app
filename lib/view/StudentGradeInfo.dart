import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muhaslti/view/GradeMark.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StudentGradeInfo extends StatefulWidget {
  const StudentGradeInfo({Key? key}) : super(key: key);

  @override
  _StudentGradeInfoState createState() => _StudentGradeInfoState();
}

class _StudentGradeInfoState extends State<StudentGradeInfo> {
  final List<YouTubeCard> cards = [];

  void _addNewVideo(BuildContext context) async {
    final videoData = await showDialog(
      context: context,
      builder: (context) => AddVideoDialog(),
    );

    if (videoData != null) {
      setState(() {
        cards.add(
          YouTubeCard(
            title: videoData['title'],
            videoId: videoData['videoId'],
            imagePath: 'images/istockphoto-493250573-1024x1024.jpg',
            subTitle: videoData['description'],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'اسم مدرس المادة',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'ElMessiri',
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 10),
                        Text(
                          'المادة',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_box),
                        onPressed: () => _addNewVideo(context),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'محتوى تعليمي',
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'اكتشف المحتوى التعليمي المميز',
                                    style: TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'الذي يساعدك على فهم المواضيع',
                                    style: TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'بشكل مبسط وسريع',
                                    style: TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return YouTubeCardWidget(cardData: cards[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الدرجات للفصول السنوية',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ' تحتوي على درجات الشهور الدراسية وملخص',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'للاداء العام',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildCard('الفصل الثاني',
                          "images/anime/Animation - 1720726943515.json"),
                      _buildCard('الفصل الاول',
                          "images/anime/Animation - 1720726943515.json")
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'لوحة التحكم للطالب',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'إدارة شاملة لأدائك الأكاديمي ومواردك التعليمية',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 400,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      children: <Widget>[
                        buildCard(context, 'جدول الحصص',
                            'images/icons8-schedule-48.png'),
                        buildCard(context, 'المناهج الدراسية',
                            'images/icons8-books-emoji-48.png'),
                        buildCard(context, 'الواجبات المنزلية',
                            'images/icons8-homework-64.png'),
                        buildCard(context, 'التقييمات الشهرية',
                            'images/icons8-bar-chart-64.png'),
                        buildCard(context, 'الفعاليات والأنشطة',
                            'images/icons8-party-100.png'),
                        buildCard(context, 'الحضور',
                            'images/icons8-attendance-64.png'),
                        buildCard(context, 'إعلانات وأخبار',
                            'images/icons8-real-time-news-64.png'),
                        buildCard(context, 'التقييم الذاتي',
                            'images/icons8-self-service-48.png'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String pathImage) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GradeStudentMark(),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 10.0, top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(pathImage, width: 120, height: 50),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'ElMessiri'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard(BuildContext context, String title, String icon) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            icon,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class YouTubeCard {
  final String title;
  final String subTitle;
  final String videoId;
  final String imagePath;

  YouTubeCard({
    required this.title,
    required this.videoId,
    required this.imagePath,
    required this.subTitle,
  });
}

class YouTubeCardWidget extends StatelessWidget {
  final YouTubeCard cardData;

  const YouTubeCardWidget({required this.cardData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openVideo(context, cardData.videoId);
      },
      child: Container(
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 100,
                  height: double.infinity,
                  child: Image.asset(
                    cardData.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cardData.title,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cardData.subTitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openVideo(BuildContext context, String videoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          liveUIColor: Colors.amber,
        ),
      ),
    );
  }
}

class AddVideoDialog extends StatefulWidget {
  @override
  _AddVideoDialogState createState() => _AddVideoDialogState();
}

class _AddVideoDialogState extends State<AddVideoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _videoIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'إضافة تعليمي جديد',
        style: TextStyle(
            fontFamily: 'ElMessiri', fontSize: 14, fontWeight: FontWeight.w900),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'العنوان',
                hintStyle: TextStyle(
                    fontFamily: 'ElMessiri',
                    fontSize: 14,
                    fontWeight: FontWeight.w900),
              ),
              textAlign: TextAlign.right,
            ),
            TextField(
              controller: _videoIdController,
              decoration: const InputDecoration(
                labelText: 'معرف الفيديو',
                hintStyle: TextStyle(
                    fontFamily: 'ElMessiri',
                    fontSize: 14,
                    fontWeight: FontWeight.w900),
              ),
              textAlign: TextAlign.right,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'الوصف',
                hintStyle: TextStyle(
                    fontFamily: 'ElMessiri',
                    fontSize: 14,
                    fontWeight: FontWeight.w900),
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'إلغاء',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'إضافة',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 14,
            ),
          ),
          onPressed: () {
            final title = _titleController.text;
            final videoId = _videoIdController.text;
            final description = _descriptionController.text;

            if (title.isNotEmpty && videoId.isNotEmpty) {
              Navigator.of(context).pop({
                'title': title,
                'videoId': videoId,
                'description': description,
              });
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _videoIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
