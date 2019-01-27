
class Receipt{
  String category;
  String id;
  String companyName;
  double expenses;
  String downloadURL;
  String date;

  Receipt({this.category, this.companyName, this.expenses, this.downloadURL,this.id,this.date});


  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["category"] = category;
    map["id"] = id;
    map["date"] = date;
    map["company_name"] = companyName;
    map["expenses"] = expenses;
    map["download_url"] = downloadURL;
    return map;
  }


}