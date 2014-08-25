class Mouse
    def self.go(maze, start, goal)
        visit(maze, start, goal, [], ->(m, r) { yield(m, r) })
    end
    
    def self.visit(maze, pt, goal, route, take)
        if isVisitable(maze, pt, route)
            route << pt
            if isGoal(route, goal)
                take.call(maze, route)
            else
                visit(maze, {x: pt[:x], y: pt[:y] + 1}, goal, route, take)
                visit(maze, {x: pt[:x] + 1, y: pt[:y]}, goal, route, take)
                visit(maze, {x: pt[:x], y: pt[:y] - 1}, goal, route, take)
                visit(maze, {x: pt[:x] - 1, y: pt[:y]}, goal, route, take)
            end
            route.pop
        end
    end
    
    def self.isVisitable(maze, pt, route)
        maze[pt[:x]][pt[:y]] == 0 and not route.include? pt
    end
   
    def self.isGoal(route, goal)
        route.include? goal
    end
end

maze = [
           [2, 2, 2, 2, 2, 2, 2, 2, 2],
           [2, 0, 0, 0, 0, 0, 0, 0, 2],
           [2, 0, 2, 2, 0, 2, 2, 0, 2],
           [2, 0, 2, 0, 0, 2, 0, 0, 2],
           [2, 0, 2, 0, 2, 0, 2, 0, 2],
           [2, 0, 0, 0, 0, 0, 2, 0, 2],
           [2, 2, 0, 2, 2, 0, 2, 2, 2],
           [2, 0, 0, 0, 0, 0, 0, 0, 2],
           [2, 2, 2, 2, 2, 2, 2, 2, 2]
       ]

Mouse.go(maze, {x: 1, y: 1}, {x: 7, y: 7}) do |maze, route|
    0.upto(maze.size - 1) do |i|
        0.upto(maze[i].size - 1) do |j|
            if route.include?({x: i, y: j})
                print "◇"
            else
                case maze[i][j]
                    when 0 then print "  "
                    when 2 then print "█"
                end
            end
        end
        puts
    end
end
