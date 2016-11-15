# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

store = Restaurant.new({name: 'あがり', hurigana: 'あがり'})
store.save
store = Restaurant.new({name: '我流屋', hurigana: 'がりゅうや'})
store.save
store = Restaurant.new({name: '通堂', hurigana: 'とんどう'})
store.save
store = Restaurant.new({name: '鳥玉', hurigana: 'とりたま'})
store.save
store = Restaurant.new({name: '三竹寿', hurigana: 'さんちくじゅ'})
store.save

@user1 = User.new({provider: 'twitter', uid: '1234567890', nickname: '1たろう', image_url: '', point: '10'})
@user1.save
@user2 = User.new({provider: 'twitter', uid: '2345678901', nickname: '2たろう', image_url: '', point: '20'})
@user2.save
@user3 = User.new({provider: 'twitter', uid: '3456789012', nickname: '3たろう', image_url: '', point: '30'})
@user3.save
