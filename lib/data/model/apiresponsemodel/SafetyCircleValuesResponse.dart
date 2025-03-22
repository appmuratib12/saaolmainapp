class SafetyCircleValuesResponse {
  bool? status;
  String? message;
  int? hapsScore;
  String? hapsComment;
  HapsParamScore? hapsParamScore;
  String? safetyCircleHapsScore;
  String? safetyCircleResult;
  SafetyCircleParamScore? safetyCircleParamScore;
  List<String>? notAvailabeleParams;
  List<String>? safetyRedZoneParam;
  List<String>? safetyYellowZoneParam;
  List<String>? safetyGreenZoneParam;
  List<Null>? safetyOtherZoneParam;

  SafetyCircleValuesResponse(
      {this.status,
        this.message,
        this.hapsScore,
        this.hapsComment,
        this.hapsParamScore,
        this.safetyCircleHapsScore,
        this.safetyCircleResult,
        this.safetyCircleParamScore,
        this.notAvailabeleParams,
        this.safetyRedZoneParam,
        this.safetyYellowZoneParam,
        this.safetyGreenZoneParam,
        this.safetyOtherZoneParam});

  SafetyCircleValuesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    hapsScore = json['haps_score'];
    hapsComment = json['haps_comment'];
    hapsParamScore = json['haps_param_score'] != null
        ? new HapsParamScore.fromJson(json['haps_param_score'])
        : null;
    safetyCircleHapsScore = json['safety_circle_haps_score'];
    safetyCircleResult = json['safety_circle_result'];
    safetyCircleParamScore = json['safety_circle_param_score'] != null
        ? new SafetyCircleParamScore.fromJson(json['safety_circle_param_score'])
        : null;
    notAvailabeleParams = json['not_availabele_params'].cast<String>();
    safetyRedZoneParam = json['safety_red_zone_param'].cast<String>();
    safetyYellowZoneParam = json['safety_yellow_zone_param'].cast<String>();
    safetyGreenZoneParam = json['safety_green_zone_param'].cast<String>();
    if (json['safety_other_zone_param'] != null) {
      safetyOtherZoneParam = <Null>[];
      json['safety_other_zone_param'].forEach((v) {
        //safetyOtherZoneParam!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['haps_score'] = this.hapsScore;
    data['haps_comment'] = this.hapsComment;
    if (this.hapsParamScore != null) {
      data['haps_param_score'] = this.hapsParamScore!.toJson();
    }
    data['safety_circle_haps_score'] = this.safetyCircleHapsScore;
    data['safety_circle_result'] = this.safetyCircleResult;
    if (this.safetyCircleParamScore != null) {
      data['safety_circle_param_score'] = this.safetyCircleParamScore!.toJson();
    }
    data['not_availabele_params'] = this.notAvailabeleParams;
    data['safety_red_zone_param'] = this.safetyRedZoneParam;
    data['safety_yellow_zone_param'] = this.safetyYellowZoneParam;
    data['safety_green_zone_param'] = this.safetyGreenZoneParam;
    return data;
  }
}

class HapsParamScore {
  dynamic cholesterol;
  dynamic triglyceride;
  dynamic hDL;
  dynamic hba1c;
  dynamic bMI;
  dynamic bP;
  dynamic zeroOil;
  dynamic walk;
  dynamic yoga;
  dynamic vegDiet;
  dynamic milk;
  dynamic fruitsAndSalad;
  dynamic stress;
  dynamic tobaccoAndSmoking;

  HapsParamScore(
      {this.cholesterol,
        this.triglyceride,
        this.hDL,
        this.hba1c,
        this.bMI,
        this.bP,
        this.zeroOil,
        this.walk,
        this.yoga,
        this.vegDiet,
        this.milk,
        this.fruitsAndSalad,
        this.stress,
        this.tobaccoAndSmoking});

  HapsParamScore.fromJson(Map<String, dynamic> json) {
    cholesterol = _handleData(json['Cholesterol']);
    triglyceride = _handleData(json['Triglyceride']);
    hDL = _handleData(json['HDL']);
    hba1c = _handleData(json['Hba1c']);
    bMI = _handleData(json['BMI']);
    bP = _handleData(json['BP']);
    zeroOil = _handleData(json['Zero Oil']);
    walk = _handleData(json['Walk']);
    yoga = _handleData(json['Yoga']);
    vegDiet = _handleData(json['Veg Diet']);
    milk = _handleData(json['Milk']);
    fruitsAndSalad = _handleData(json['Fruits And Salad']);
    stress = _handleData(json['Stress']);
    tobaccoAndSmoking = _handleData(json['Tobacco And Smoking']);
  }

  // Helper function to handle dynamic data types (String or Integer)
  dynamic _handleData(dynamic value) {
    if (value is String) {
      return value; // Keep as String if it's already a String
    } else if (value is int || value is double) {
      return value.toString(); // Convert to String if it's an Integer or Double
    } else {
      return value; // Return as-is if the value is already in an acceptable format
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Cholesterol'] = this.cholesterol;
    data['Triglyceride'] = this.triglyceride;
    data['HDL'] = this.hDL;
    data['Hba1c'] = this.hba1c;
    data['BMI'] = this.bMI;
    data['BP'] = this.bP;
    data['Zero Oil'] = this.zeroOil;
    data['Walk'] = this.walk;
    data['Yoga'] = this.yoga;
    data['Veg Diet'] = this.vegDiet;
    data['Milk'] = this.milk;
    data['Fruits And Salad'] = this.fruitsAndSalad;
    data['Stress'] = this.stress;
    data['Tobacco And Smoking'] = this.tobaccoAndSmoking;
    return data;
  }
}

class SafetyCircleParamScore {
  int? serumCholesterol;
  int? serumTriglycederide;
  int? hdlVsCholesterol;
  int? bp;
  int? hba1c;
  int? bmi;
  int? zeroOil;
  int? vegeterianism;
  int? milkDairy;
  int? fruitSaladVegetable;
  int? stress;
  int? tobaccoSmoking;
  int? walk;
  int? yoga;

  SafetyCircleParamScore(
      {this.serumCholesterol,
        this.serumTriglycederide,
        this.hdlVsCholesterol,
        this.bp,
        this.hba1c,
        this.bmi,
        this.zeroOil,
        this.vegeterianism,
        this.milkDairy,
        this.fruitSaladVegetable,
        this.stress,
        this.tobaccoSmoking,
        this.walk,
        this.yoga});

  SafetyCircleParamScore.fromJson(Map<String, dynamic> json) {
    serumCholesterol = json['serum_cholesterol'];
    serumTriglycederide = json['serum_triglycederide'];
    hdlVsCholesterol = json['hdl_vs_cholesterol'];
    bp = json['bp'];
    hba1c = json['Hba1c'];
    bmi = json['bmi'];
    zeroOil = json['zero_oil'];
    vegeterianism = json['vegeterianism'];
    milkDairy = json['milk_dairy'];
    fruitSaladVegetable = json['fruit_salad_vegetable'];
    stress = json['stress'];
    tobaccoSmoking = json['tobacco_smoking'];
    walk = json['walk'];
    yoga = json['yoga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serum_cholesterol'] = this.serumCholesterol;
    data['serum_triglycederide'] = this.serumTriglycederide;
    data['hdl_vs_cholesterol'] = this.hdlVsCholesterol;
    data['bp'] = this.bp;
    data['Hba1c'] = this.hba1c;
    data['bmi'] = this.bmi;
    data['zero_oil'] = this.zeroOil;
    data['vegeterianism'] = this.vegeterianism;
    data['milk_dairy'] = this.milkDairy;
    data['fruit_salad_vegetable'] = this.fruitSaladVegetable;
    data['stress'] = this.stress;
    data['tobacco_smoking'] = this.tobaccoSmoking;
    data['walk'] = this.walk;
    data['yoga'] = this.yoga;
    return data;
  }
}
