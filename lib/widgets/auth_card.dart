// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_halo_task/models/auth_card_model.dart';

class AuthCards extends StatefulWidget {
  const AuthCards({super.key});

  @override
  State<AuthCards> createState() => _AuthCardsState();
}

class _AuthCardsState extends State<AuthCards> {
  List<AuthCardModel> authModels = [];

  void authCard() {
    authModels = AuthCardModel.authCard(context);
  }

  @override
  void initState() {
    super.initState();
    authCard();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: authModels.length,
        itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(20),
            elevation: 1,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                setState(() {
                  authModels[index].onTap();
                  debugPrint("Tapped");
                });
              },
              radius: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    authModels[index].svg == false
                        ? Image.asset(
                            authModels[index].widgetUrl,
                            height: 70,
                            width: 75,
                          )
                        : SvgPicture.asset(
                            authModels[index].widgetUrl,
                            height: 60,
                            alignment: Alignment.bottomLeft,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      authModels[index].text,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
