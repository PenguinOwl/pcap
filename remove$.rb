
x = gets.strip
file = File.open(x,"r+")
file2 = File.new(x.gsub(".txt","_new.txt"),"w+")
file2.write(file.read.gsub(/(.+)\s-\s(.+)\s\$(.+)/) { if $3 then $1.gsub("/\W/","") + " " + $2.gsub("/\W/","") + " " + $3.gsub("/\W/","") })
file.close
file2.close
