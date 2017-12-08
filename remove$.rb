
x = gets.strip
file = File.open(x,"r+")
file2 = File.new(x.gsub(".txt","_new.txt"),"w+")
file2.write(file.read.gsub(/(.+)\s-\s(.+)\s\$(.+)/) { 
  if $3 != nil and $2 != nil and $1 != nil
    a1, a2, a3 = $1,$2,$3
    a1.gsub("/\W/","") + " " + a2.gsub("/\W/","") + " " + a3.gsub("/\W/","") 
  end 
  })
file.close
file2.close
