# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

store = Restaurant.new({name: 'あがり', num_seats: '20', num_people: '0', seats_occ: '0'})
store.save
store = Restaurant.new({name: '我流屋', num_seats: '24', num_people: '0', seats_occ: '0'})
store.save
store = Restaurant.new({name: '通堂', num_seats: '40', num_people: '0', seats_occ: '0'})
store.save
store = Restaurant.new({name: '鳥玉', num_seats: '26', num_people: '0', seats_occ: '0'})
store.save
store = Restaurant.new({name: '三竹寿', num_seats: '23', num_people: '0', seats_occ: '0'})
store.save
