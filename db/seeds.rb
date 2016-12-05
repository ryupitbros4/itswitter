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
