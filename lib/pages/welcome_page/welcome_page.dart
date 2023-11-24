// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:new_halo_task/models/welcome_pages_model.dart';
import 'package:new_halo_task/pages/welcome_page/build_dot.dart';
import 'package:new_halo_task/pages/welcome_page/next_button.dart';

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
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
                  (index) => BuildDot(
                    index: index,
                    currentIndex: currentIndex,
                  ),
                ),
              ),
              NextPageButton(
                controller: _controller,
                currentIndex: currentIndex,
                welcomeModel: welcomeModel,
              ),
            ],
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
