# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# エリア     1       2      3      4      5     6      7     8      9    10     11
Areas = ['北海道', '東北','関東','甲信越','北陸','東海','近畿','中国','四国','九州','沖縄']
Areas.each do |area|
	Area.create!(
		name: area
	)
end

#都道府県
require "csv"
CSV.foreach('db/prefecture.csv', headers: true) do |row|
	Prefecture.create!(
		name: row['name'],
		area_id: row['area_id']
	)
end


#ジャンル
Genres = ['グルメ','景色','体験','イベント','言葉','トレンド','その他']

Genres.each do |genre|
	Genre.create!(
		name: genre
	)
end

#管理者
Admin.create!(
	email: 'admin@mail',
	password: 'adminadmin'
	)

#ユーザー
User.create!(
	[
		{
		name: 'yamada',
		email: 'yamada@mail',
		image: File.open('./app/assets/images/icon.jpeg'),
		password: '111111' 
		},
		{
			name: 'tanaka',
			email: 'tanaka@mail',
			password: '222222'
		}
	])

# 投稿
Post.create!(
	[
		{
			user_id: 1,
			genre_id: 1,
			prefecture_id: 40,
			title: '明太卵焼き',
			body: '激ウマ',
			image: File.open('./app/assets/images/mentaitamago.jpg')
		},
		{
			user_id: 2,
			genre_id: 1,
			prefecture_id: 34,
			title: '屋台のおでん',
			body: 'うますぎ',
			image: File.open('./app/assets/images/oden.jpg')
		},
		{
			user_id: 2,
			genre_id: 2,
			prefecture_id: 20,
			title: '美ヶ原から見える絶景',
			body: '絶景スポット',
			image: File.open('./app/assets/images/matsumoto.jpg')
		}
	])










