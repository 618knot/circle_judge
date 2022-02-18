### ブランチの運用について

- `main`を本番用
- `dev`を開発用
  と分けて運用していきたいです。

**上記による変更点**

1. 作業ブランチは dev に checkout してから切る
2. PR 提出時は dev に向けて出す
3. マージ後の動作確認は dev に移動して行う

### 作業手順

`git clone https://github.com/618knot/circle_judge.git`

クローンしたリポジトリに移動し、  
`git Bush Here`  
or  
パスに直接`cmd`を打ち込んでコマンドプロンプトを起動  
![2021-08-18](https://user-images.githubusercontent.com/60646787/129768468-68da948c-b6e7-408b-a289-13c0ed41f86c.png)  
(※Windows)

`git branch`  
で自分が今いるブランチを確認する.  
`git checkout -b fix_0_XXXXXX`  
0 には issue 番号、`XXXXX`には任意の issue 名を記述.  
で issue に対応するブランチを作成し移動した状態になる.  
(ここでもう一度`git branch`をすると移動していることを確認できます.  
例:

```
$ git branch
  fix_6_get_coordinates_on_player
* fix_7_camera_follows_player // 現在地
  main
```

)  
作業が終わったらいったんコミットしてプッシュしましょう.  
以下のコマンドを順次実行する

`git pull`  
`git add .` or `git add hogehoge` hogehoge には add したいファイルのパスが入ります  
`git commit`  
`:任意のprefix: XXXを実装した`  
[prefix のつけ方参考 gif](https://media.goodpatch.com/cms/2016/06/emojiprefix.gif)  
`git push origin fix_0_XXXXXX` or `git push origin HEAD`  
(HEAD で今いるブランチの origin に向けて puhs します.間違いが起こりやすいので、**現在位置が自分の作業中のブランチであることを必ず確認してから使いましょう**)

### プルリクエストを出す

![2021-08-18 (1)](https://user-images.githubusercontent.com/60646787/129770683-7c7f2ec4-7596-4a79-b577-521640c96640.png)

1. New Pull request からプルリクエストを新規に作成.
2. 矢印を生やしている方の`compare:`を選択し、自分の作業したブランチ(`fix_0_XXXXXX`)を指定.  
   ![2021-08-18 (3)](https://user-images.githubusercontent.com/60646787/129771016-2acf68e7-7d7e-4923-b2f8-fbdefc3ed17f.png)
3. Write 欄に`fixed #0`と書く.`0`には紐づけたい issue 番号が入る. ([参考](https://docs.github.com/ja/issues/tracking-your-work-with-issues/creating-issues/linking-a-pull-request-to-an-issue))

- プルリクがマージされると、ここでリンクさせた issue もクローズされます

4. `Reviewers`に任意のレビュアーを指定(なるべく全員を指定する)
5. 上記の設定でプルリクを作成

### プルリクエストをマージするまで

1. レビュアーは`Files changed`から変更点を確認する![2021-08-18 (12)](https://user-images.githubusercontent.com/60646787/129828810-1d19e7f2-19ab-45da-977c-c1b6489dad68.png)  
   (Unity は構造上ここのファイルが多くなるので全部に目を通すのは大変そう.Scripts など目視で確認可能なところに目を通してみるとよさそう)  
   (あるいは手元でブランチを pull してきて動作確認をする)
2. 右上の緑のボタン(`Review change`)を選択し、問題があればコメント or なければ`approve`(プルリクを承認)する.
3. 最後に`approve`した人がマージしましょう. ここで conflict を起こしていたら、無理にマージせずメンバーに相談しましょう.

- コードレビューのコメントに対しては修正後にその旨を返信し、レビュアーは問題が解決したらコメントを close する.

4. マージができたら用が済んだ issue を close し、`git checkout main`→`git pull origin main`で手元の main ブランチを最新の状態にするのを忘れずに.

### Issue について

1. Issue はラベルが設定できます.`UI`/`API`などあるので必要に応じて設定しましょう.
2. asigner に作業をする人を設定しましょう.設定することで,誰が何をしているのかをわかりやすくすることがねらいです.

### マージ/レビュアーについて

マージ担当者は各チームで担当者を決める

### prefix

# ==================== Emojis ====================

# 🎉 :tada: 初めてのコミット（Initial Commit）

# 🔖 :bookmark: バージョンタグ（Version Tag）

# ✨ :sparkles: 新機能（New Feature）

# 🐛 :bug: バグ修正（Bugfix）

# ♻️ :recycle: リファクタリング(Refactoring)

# 📚 :books: ドキュメント（Documentation）

# 🎨 :art: デザイン UI/UX(Accessibility)

# 🐎 :horse: パフォーマンス（Performance）

# 🔧 :wrench: ツール（Tooling）

# 🚨 :rotating_light: テスト（Tests）

# 💩 :hankey: 非推奨追加（Deprecation）

# 🗑️ :wastebasket: 削除（Removal）

# 🚧 :construction: WIP(Work In Progress)

# hello_world

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
