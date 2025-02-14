enum PaymentMethod{
  telebirr(name:"Telebirr",code:"TELEBIRR_USSD"),
  mpesaa(name:"Mpesaa",code:"MPESA");

  final String name;
  final String code;

  const PaymentMethod({required this.name, required this.code});

}