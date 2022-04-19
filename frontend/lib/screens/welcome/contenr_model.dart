class UnboardingContent {
  String image;
  String title;

  UnboardingContent({required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
    title: 'Record your daily income\nand expenses',
    image: 'images/Money-back guarantee.svg',
  ),
  UnboardingContent(
      title: 'Record your daily income\nand expenses',
      image: 'images/Invest.svg'),
  UnboardingContent(
      title: 'Get notification for dailt\nrecording and bill expenses',
      image: 'images/Notifications.svg'),
];
