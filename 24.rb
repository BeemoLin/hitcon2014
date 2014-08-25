require 'net/telnet'

  EXPRESSIONS = [
    '((%d %s %d) %s %d) %s %d',
    '(%d %s (%d %s %d)) %s %d',
    '(%d %s %d) %s (%d %s %d)',
    '%d %s ((%d %s %d) %s %d)',
    '%d %s (%d %s (%d %s %d))',
  ].map{|expr| [expr, expr.gsub('%d', 'Rational(%d,1)')]}
 
  OPERATORS = [:+, :-, :*, :/].repeated_permutation(3)
 
  OBJECTIVE = Rational(24,1)
 
  def solve(digits)
    solutions = []
    digits.permutation.to_a.uniq.each do |a,b,c,d|
      OPERATORS.each do |op1,op2,op3|
        EXPRESSIONS.each do |expr,expr_rat|
          # evaluate using rational arithmetic
          test = expr_rat % [a, op1, b, op2, c, op3, d]
          value = eval(test) rescue -1  # catch division by zero
          if value == OBJECTIVE
            solutions << expr % [a, op1, b, op2, c, op3, d]
          end
        end
      end
    end
    solutions
  end

def connent()
  Net::Telnet.new(
    'Host' => "210.65.89.59",
    'Port' => 2424,
    'Timeout' => 600,
    'Waittime' => 1,
    'Binmode' => true,
    'Output_log' => "output.txt",
    'Dump_log' => "dumpbbq.txt"
  )
end

tn = connent()

place = '(\d*, \d*, \d*, \d*)'

@temp = ''
loop do
  unless(@temp=='')
    line = @temp
    print(@temp)
  else
    line = tn.waitfor(/#{place}/){|w| print(w) }
  end
  
  a = line.scan(/#{place}/)[0].to_s

  hands = a.gsub(/ /, "").gsub(/"/, "").gsub(/\[/, "").gsub(/\]/, "").split(",").map(&:to_s)
  
  if hands.size == 0
    @temp = ''
    tn.close
    tn = connent()
  else
    temp_ans = solve(hands)
  end

  unless temp_ans.empty?
    ans = temp_ans.first.gsub(/ /, "").gsub(/\n/, "").gsub(/\r/, "")
    print("#{ans} ")
    @temp = tn.cmd("String" => "#{ans}","Match" => /Great/) 
  else
    print("No solutions!!\n")
    @temp = ''
    tn.close
    tn = connent()
  end
end
