# -*- coding: utf-8 -*-
require 'csv'

CSV.foreach('db/gnavi_ryudai_rest.csv') do |row|
  Restaurant.create(gid: row[0], name: row[1], hurigana: row[2])
end

