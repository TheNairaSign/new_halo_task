
class WelcomePageModel {
  String image, description;
  bool button;

  WelcomePageModel({
    required this.image,
    required this.description,
    required this.button,

  });

  static List<WelcomePageModel> welcomePageModel() {
    List<WelcomePageModel> welcomeModel = [];

    welcomeModel.add(
      WelcomePageModel(
        image: "assets/halo-task.png",
        description: "Easy Work and Task Management with Halo",
        button: false
      ),
    );
    welcomeModel.add(
      WelcomePageModel(
        image: "assets/task.png",
        description: "Easy Work and Task Management with Master",
        button: false
      ),
    );
    welcomeModel.add(
      WelcomePageModel(
        image: "assets/white-task.png",
        description: "Easy Work and Task Management with Pamo",
        button: true
      ),
    );
    return welcomeModel;
  }
}
