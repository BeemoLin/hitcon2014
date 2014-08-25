require 'net/telnet'

tn = Net::Telnet.new(
  'Host' => "210.71.253.213",
  'Port' => 8473,
  'Timeout' => 600,
  'Waittime' => 0,
  'Output_log' => "output.txt",
  'Dump_log' => "dumpbbq.txt"
)

@left = "\e[A"
@up = "\e[B"
@right = "\e[C"
@down = "\e[D"

while 1 > 0 do
  tn.print @right
  tn.waitfor(//){ |s| puts(s) }
  
  sleep(1)
end
