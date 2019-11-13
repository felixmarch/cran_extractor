#!/usr/bin/env ruby

MAX_PACKAGES=50 #change this to limit the number of packages
DB_PACKAGES={}

cran=`curl -k https://cran.r-project.org/src/contrib/PACKAGES`
#cran = `cat packages.txt`
#puts packages

class String
  def trim_multiline()
    return self.gsub(/\n[ ]{1,}/,' ')
  end
end

packages = cran.split("\n\n").collect { |s| 
  s.trim_multiline.split("\n").each_with_object({}) { |e,o|  
    key, val = e.split(": ")
    o[key.to_sym]=val
} }

packages[0..(MAX_PACKAGES-1)].each_with_object(DB_PACKAGES) { |p, o| 
  filename="#{p[:Package]}_#{p[:Version]}.tar.gz" 
  p[:Tarball]=filename
  desc = `curl -k https://cran.r-project.org/src/contrib/#{filename} | tar -zxO #{p[:Package]}/DESCRIPTION`
  #puts desc.gsub(/\n[ ]{1,}/,' ')
  desc.gsub(/\n[ ]{1,}/,' ').split("\n").each_with_object(p) { |e,o|
    key, val = e.split(": ")
    p[key.to_sym]=val
  }
  #puts p
  o[p[:Package]] = p
}

#packages[0].each{|k,v| puts "#{k}: #{v}"}

File.open("cran.marshal", "w"){|to_file| Marshal.dump(DB_PACKAGES, to_file)}


