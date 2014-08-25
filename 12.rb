def solve(numbers_orig)
  operators_orig = ["+", "-", "*", "/"]
  op_permutation = operators_orig.repeated_permutation(3)
  num_permutation = numbers_orig.permutation(4).to_a.uniq
  current_result = 0
  num_permutation.each do |numbers|
    op_permutation.each do |operators|
      current_result = numbers[0].to_f
      operators.each_with_index do |operator, index|
        current_result = current_result.send(operator.to_sym, numbers[index+1].to_f)
      end
      if current_result == 24
          return "((#{numbers[0]} #{operators[0]} #{numbers[1]}) #{operators[1]} #{numbers[2]}) #{operators[2]} #{numbers[3]} = 24"
          break
      end
    end
  end
  return "No solution found"
end

ans = solve([1, 5, 5, 5])
puts(ans)