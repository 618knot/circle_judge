//Questionの情報を持つクラス
class Result {
  int circlerank;
  String circlename;
  double percent;
  String circle_image_url;
  String circle_description;
  Result(this.circlerank, this.circlename, this.percent, this.circle_image_url,
      this.circle_description) {}
}

//Singletonでデータをキャッシュする
class ResultData {
  static final Map<int, Result> _item = <int, Result>{};
  static final ResultData _cache = ResultData._internal();
  static int? gameId;

  factory ResultData() {
    return _cache;
  }
  // @override
  // initstate(){
  //   print("initstatecall");
  //   ResultData().set(
  //       -1,
  //       Result(0, "読み込み中", 0, "",
  //           "読み込み中"));
  // }
  ResultData._internal();
  set(int key, Result value) => _item[key] = value;
  get(int key) => _item[key];
  //サークルを返す
  GetCircle(int num){
    if(ResultData().get(num)==null){
      return ResultData().get(-1);
    }
    return ResultData().get(num);
  }
  //サークル名を返す
  GetName(int num){
    return ResultData().get(num).circlename;
  }
  //画像を返す
  GetImage(int num){
    return ResultData().get(num).circle_image_url;
  }
  //説明文を返す
  GetDC(int num){
    return ResultData().get(num).percent;
  }
  //説明文を返す
  Getper(int num){
    return ResultData().get(num).circle_description;
  }
/*
  //質問数を返す
  getlength()=>_item.length;


  //answer 1:Yes 0:Even -1:No
  SetAnswer(int answer,int num){
    Question question=QuestionData().get(num);
    if(answer==1){
      question.Answer="Yes";
    }
    else if(answer==-1){
      question.Answer="No";
    }
    else if(answer==0){
      question.Answer="Even";
    }
    else{
      print("回答が不正です");
    }
  }
  */
}
