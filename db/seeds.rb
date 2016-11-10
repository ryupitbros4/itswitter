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

user = User.new({provider: 'twitter', uid: '1234567890', nickname: '1たろう', image_url: '', point: '11'})
user.save
user = User.new({provider: 'twitter', uid: '2345678901', nickname: '2たろう', image_url: '', point: '22'})
user.save
user = User.new({provider: 'twitter', uid: '3456789012', nickname: '3たろう', image_url: '', point: '33'})
user.save
user = User.new({provider: 'twitter', uid: '4567890123', nickname: '4たろう', image_url: '', point: '44'})
user.save
user = User.new({provider: 'twitter', uid: '5678901234', nickname: '5たろう', image_url: '', point: '55'})
user.save
