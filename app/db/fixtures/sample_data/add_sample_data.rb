# 最初に自分のユーザーレコードを作ってから実行しないとエラーになります。

user = User.find(1)

Circle.seed do |s|
  s.id = 1
  s.name = "サンプルサークル"
  s.owner = user
  s.introduction = "サンプルだよ！一緒に遊んでくれると嬉しいです！"
  s.introduction_picture_url = "https://assets-cdn.github.com/images/modules/logos_page/Octocat.png"
  s.default_auto_reply_comment = "参加申請ありがとうございます！ぜひきてください！"
end

a_week_after = Time.zone.today + 7
Activity.seed do |s|
  s.circle = Circle.find(1)
  s.place_content = PlaceContent.find(1)
  s.date = a_week_after
  s.start_time = Time.zone.local(a_week_after.year, a_week_after.mon, a_week_after.mday, 16, 0, 0)
  s.end_time = Time.zone.local(a_week_after.year, a_week_after.mon, a_week_after.mday, 19, 0, 0)
end

tomorrow = Time.zone.tomorrow
Activity.seed do |s|
  s.circle = Circle.find(1)
  s.place_content = PlaceContent.find(1)
  s.date = a_week_after
  s.start_time = Time.zone.local(tomorrow.year, tomorrow.mon, tomorrow.mday, 10, 0, 0)
  s.end_time = Time.zone.local(tomorrow.year, tomorrow.mon, tomorrow.mday, 13, 0, 0)
end
