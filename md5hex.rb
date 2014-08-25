require "digest/md5"

#ys = "urpou17pr1vfo7m0"
ys = "a0"
ys = ys.chars.each_slice(16).map(&:join)
m = ys.map{|y| Digest::MD5.hexdigest(y)}
           #.to_i(16)}.inject(:+)
print(m)
