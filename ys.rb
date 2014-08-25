require "digest/md5"
require 'net/telnet'

def watch(ya)
	ys = ya.chomp
	ys = ys+"00000000000"
	ys = ys.chars.each_slice(16).map(&:join)
	m = ys.map{|y| Digest::MD5.hexdigest(y).to_i(16)}.inject(:+)
  return m	
end

tn = Net::Telnet.new(
  'Host' => "210.71.253.236",
  'Port' => 7171,
  'Timeout' => 600,
  'Waittime' => 0,
  'Output_log' => "output.txt",
  'Dump_log' => "dumpbbq.txt"
)
place = '"\w*", "\w*", "\w*"'
@temp = ''
loop do
  unless(@temp=='')
    line = @temp
    print(@temp)
  else
	  line = tn.waitfor(/#{place}/)
  end

  a = line.scan(/#{place}/)[0]
  hands = a.gsub(/ /, "").gsub(/\"/, "").split(",").map(&:to_s)
  print("\nget.......#{hands}\n")
  print(line)
  print("1\n")
  tn.cmd("String" => "1", "Match" => /the magic\?/){|c| print(c)}
  m = watch(hands[0]).to_s
  print("#{m}")
  line = tn.cmd("String" => m, "Match" => /mine: \w*/)
  b = line.scan(/mine: \w*/)[0]
  mine = b.gsub(/mine: /, "")
  
  xi = hands.index(mine)
  print("\nboss select:#{mine}[#{xi}]\n") 
  yi = 0 
  attack = hands[0]+"00000000000"
  puts("you select:#{hands[0]}[#{yi}]")
  if xi == (yi + 1) % 3
    puts("no.....")
    @temp = tn.cmd("String" => '1', "Match" => /how many\?/){|c| print(c) }
  elsif xi == (yi - 1) % 3
    puts("attack")
    @temp = tn.cmd("String" => attack, "Match" => /how many\?/){|c| print(c) }
  else
    puts("do nothing") 
    @temp = tn.cmd("String" => attack, "Match" => /how many\?/){|c| print(c) }
  end
end
