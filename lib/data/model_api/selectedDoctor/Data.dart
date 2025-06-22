class Data {
  Data({
    this.drID,
    this.drName,
    this.drEmail,
    this.drPassword,
    this.drPhone,
    this.drGender,
    this.drDegree,
    this.specialty,
    this.rating,
    this.drAge,
    this.drPhoto,
    this.drAddress,
    this.yearExperience,
    this.price,
    this.day,
    this.date,});

  Data.fromJson(dynamic json) {
    drID = json['Dr_ID'];
    drName = json['Dr_Name'];
    drEmail = json['Dr_Email'];
    drPassword = json['Dr_Password'];
    drPhone = json['Dr_Phone'];
    drGender = json['Dr_Gender'];
    drDegree = json['Dr_Degree'];
    specialty = json['Specialty'];
    rating = json['Rating'];
    drAge = json['Dr_Age'];
    drPhoto = json['Dr_Photo'];
    drAddress = json['Dr_Address'];
    yearExperience = json['Year_Experience'];
    price = json['price'];
    day = json['Day'];
    date = json['Date'];
  }
  num? drID;
  String? drName;
  String? drEmail;
  String? drPassword;
  String? drPhone;
  String? drGender;
  String? drDegree;
  String? specialty;
  num? rating;
  num? drAge;
  dynamic drPhoto;
  String? drAddress;
  dynamic yearExperience;
  dynamic price;
  String? day;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Dr_ID'] = drID;
    map['Dr_Name'] = drName;
    map['Dr_Email'] = drEmail;
    map['Dr_Password'] = drPassword;
    map['Dr_Phone'] = drPhone;
    map['Dr_Gender'] = drGender;
    map['Dr_Degree'] = drDegree;
    map['Specialty'] = specialty;
    map['Rating'] = rating;
    map['Dr_Age'] = drAge;
    map['Dr_Photo'] = drPhoto;
    map['Dr_Address'] = drAddress;
    map['Year_Experience'] = yearExperience;
    map['price'] = price;
    map['Day'] = day;
    map['Date'] = date;
    return map;
  }}