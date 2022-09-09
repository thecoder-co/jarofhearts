import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map> data = [
    {'image': true, 'data': 'assets/1.jpg'},
    {
      'image': false,
      'data':
          'The first time I saw you, at love garden, you looked as regal as this.',
    },
    {
      'image': false,
      'data':
          "I was honestly awestruck. Like, who is this woman with flowing long hair and beautiful lashes.",
    },
    {
      'image': false,
      'data':
          "I'm not even kidding. The way you said you liked my nails had me doing backflips inside.",
    },
    {
      'image': true,
      'data': "assets/2.gif",
    },
    {
      'image': false,
      'data': "I thought you looked so beautiful🥺",
    },
    {
      'image': false,
      'data':
          "I don't know why you don't think the same, but you're a really amazing person. ISTG.",
    },
    {
      'image': true,
      'data': "assets/IMG-20211001-WA0107.jpg",
    },
    {
      'image': false,
      'data': "And I feel light AF when I'm with you😂😂😂😂",
    },
    {
      'image': false,
      'data': "The kind of light that you just want to be like that forever.",
    },
    {
      'image': true,
      'data': "assets/IMG-20211001-WA0117.jpg",
    },
    {
      'image': false,
      'data':
          "You sat up so straight. I never knew backs could be so straight.",
    },
    {
      'image': true,
      'data': "assets/4.jpg",
    },
    {
      'image': false,
      'data':
          "Walking with you, basking in your presence, in unilag. That's probably the highlight of the whole semester.",
    },
    {
      'image': true,
      'data': "assets/IMG-20211001-WA0113.jpg",
    },
    {
      'image': false,
      'data': "Goofy human being😂😂😂",
    },
    {
      'image': false,
      'data':
          "It's one of my favourite things about you, how you're so carefree.",
    },
    {
      'image': false,
      'data':
          "Unlike you, i can't out of the blue decide to go to some club, lest I'd break down in an anxiety attack.",
    },
    {
      'image': true,
      'data': "assets/IMG-20211001-WA0109.jpg",
    },
    {
      'image': false,
      'data': "I want to go on adventures with you.",
    },
    {
      'image': false,
      'data':
          "Walk down an empty beach on your birthday and sip wine together, while we watch the sunset.",
    },
    {
      'image': false,
      'data': "I'd probably tell you that you look better than the sun.",
    },
    {
      'image': false,
      'data': "In actual fact, you do look better than the sun.",
    },
    {
      'image': true,
      'data': "assets/IMG-20211001-WA0112.jpg",
    },
    {
      'image': false,
      'data': "I love your smile so much🥺",
    },
    {
      'image': false,
      'data':
          "You see, if anyone deserves to have the best birthday ever, it has to be you.",
    },
    {
      'image': false,
      'data': "Happy birthday, Grace.🥺",
    },
    {
      'image': false,
      'data': "OMG. Happy birthday.🥺😭😭😭😭",
    },
    {
      'image': false,
      'data':
          "My kidney is also for sale, but if you ever need one, I'll give it at a moments notice. I have two anyway.🥺😂",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff0047AB),
              Color(0xffF4989C),
            ],
          ),
        ),
        child: Swiper(
          itemCount: data.length,
          autoplay: true,
          autoplayDelay: 5000,
          autoplayDisableOnInteraction: true,
          curve: Curves.ease,
          duration: 1000,
          loop: false,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          viewportFraction: 0.8,
          scale: 0.8,
          itemBuilder: (context, index) {
            if (!data[index]['image']) {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10,
                  bottom: MediaQuery.of(context).size.height * 0.10,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF02040F),
                  ),
                  child: Center(
                    child: Text(
                      data[index]['data'],
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffA1C6EA),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10,
                  bottom: MediaQuery.of(context).size.height * 0.10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF02040F), width: 3),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        data[index]['data'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
