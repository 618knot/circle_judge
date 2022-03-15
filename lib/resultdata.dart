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
  ResultData._internal();
  set(int key, Result value) => _item[key] = value;
  get(int key) => _item[key];
/*
  //質問数を返す
  getlength()=>_item.length;
  //質問文を返す
  GetQuestion(int num){
    Question question=QuestionData().get(num);
    //String tmp=Q.question_sentence;
    return question.question_sentence;
  }
  //質問画像を返す
  GetImage(int num){
    Question question=QuestionData().get(num);
    //String tmp=Q.question_sentence;
    return question.question_image;
  }
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
