
x = gets.strip
file = File.open(x,"r+")
file2 = File.new(x.gsub(".txt","_new.txt"),"w+")
file2.write(file.read.gsub(/(.+)\s-\s(.+)\s\$(.+)/) { if $3 != nil and $2 != nil and $1 != nil then $1.gsub("/\W/","") + " " + $2.gsub("/\W/","") + " " + $3.gsub("/\W/","") end })
file.close
file2.close
