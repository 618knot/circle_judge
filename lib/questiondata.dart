import 'package:flutter/material.dart';

//Questionの情報を持つクラス
class Question{
  int question_number;
  String question_sentence;
  String question_image;
  Question(this.question_number,this.question_sentence,this.question_image){}
}

//Singletonでデータをキャッシュする
class QuestionData{
  static final Map<int, Question> _item = <int, Question>{};
  static final QuestionData _cache=QuestionData._internal();
  static int? gameId;

  factory QuestionData() {
    return _cache;
  }
  QuestionData._internal();
  set(int key, Question value) => _item[key] = value;
  get(int key) => _item[key];
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
}