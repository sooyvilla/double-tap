class UrlImage {
  static String urlCardSmall(String playerCardID) =>
      'https://media.valorant-api.com/playercards/$playerCardID/smallart.png';
  static String urlCardWide(String playerCardID) =>
      'https://media.valorant-api.com/playercards/$playerCardID/wideart.png';
  static String urlCardLarge(String playerCardID) =>
      'https://media.valorant-api.com/playercards/$playerCardID/largeart.png';
}
