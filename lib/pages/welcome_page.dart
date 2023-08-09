import 'package:flutter/material.dart';
import 'package:new_halo_task/models/welcome_pages_model.dart';
import 'package:new_halo_task/pages/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<WelcomePageModel> welcomeModel = [];

  void _welcomModel() {
    welcomeModel = WelcomePageModel.welcomePageModel();
  }

  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _welcomModel();
    _controller;
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 500,
                child: pageView(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  welcomeModel.length,
                  (index) => buildDot(index, context),
                ),
              ),
              nextButton(currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 7,
      width: currentIndex == index ? 20 : 7,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.pinkAccent : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  SizedBox nextButton(int index) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton(
        onPressed: () {
          if (currentIndex == welcomeModel.length - 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => LoginPage(showLoginPage: () {},),
              ),
            );
          }
          _controller.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceIn,
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.pinkAccent,
          ),
        ),
        child: currentIndex == welcomeModel.length - 1
            ? const Text(
                "Continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text(
                "Next",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  PageView pageView() {
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: _controller,
      itemCount: welcomeModel.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(welcomeModel[i].image),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  welcomeModel[i].description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
