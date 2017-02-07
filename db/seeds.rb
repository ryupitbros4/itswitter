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

store = Restaurant.new({name: 'がががが', hurigana: 'がががが'})
store.save
store = Restaurant.new({name: 'ぎぎぎぎ', hurigana: 'ぎぎぎぎ'})
store.save
store = Restaurant.new({name: 'ぐぐぐぐ', hurigana: 'ぐぐぐぐ'})
store.save
store = Restaurant.new({name: 'げげげげ', hurigana: 'げげげげ'})
store.save
store = Restaurant.new({name: 'ごごごご', hurigana: 'ごごごご'})
store.save

store = Restaurant.new({name: 'ざざざざ', hurigana: 'ざざざざ'})
store.save

store = Restaurant.new({name: 'だだだだ', hurigana: 'だだだだ'})
store.save

store = Restaurant.new({name: 'ばばばば', hurigana: 'ばばばば'})
store.save

store = Restaurant.new({name: 'ぱぱぱぱ', hurigana: 'ぱぱぱぱ'})
store.save
store = Restaurant.new({name: 'ぴぴぴぴ', hurigana: 'ぴぴぴぴ'})
store.save
store = Restaurant.new({name: 'ぷぷぷぷ', hurigana: 'ぷぷぷぷ'})
store.save
store = Restaurant.new({name: 'ぺぺぺぺ', hurigana: 'ぺぺぺぺ'})
store.save
store = Restaurant.new({name: 'ぽぽぽぽ', hurigana: 'ぽぽぽぽ'})
store.save
