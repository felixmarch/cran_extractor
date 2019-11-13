#!/usr/bin/ruby

packages = File.open("cran.marshal", "r"){|from_file| Marshal.load(from_file)}


packages.each {|name, p| 
    puts "#{"="*20} #{name} #{"="*20}"
    p.each{|k,v| puts "* [#{k}] : #{v}"} 
    puts "="*50
}
