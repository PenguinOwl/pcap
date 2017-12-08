
x = gets.strip
file = File.open(x,"r+")
file2 = File.new(x.gsub(".txt","_new.txt"),"w+")
file2.write(file.read.gsub(/(.+)\s-\s(.+)\s\$(.+)/, $1 + $2 + $3))
file.close
file2.close
