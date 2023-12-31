require 'time'

def solution(s)
  photos = s.split("\n").each_with_index.map { |photo, index| parse(photo, index) }.group_by { |photo| photo[:city] }

  photos.each_value do |city_photos|
    city_photos.sort_by! { |photo| photo[:timestamp] }
    n = city_photos.length.to_s.length
    city_photos.each_with_index do |photo, idx|
      photo[:name] = sprintf("%s%0#{n}d.%s", photo[:city], (idx + 1), photo[:ext])
    end
  end

  photos.values.flatten.sort_by { |photo| photo[:index]}.map { |photo| photo[:name] }.join("\n")
end

def parse(photo, index)
  name, city, timestamp = photo.split(", ")
  {
    city: city,
    timestamp: Time.parse(timestamp),
    name: name.partition(".").first,
    ext: name.partition(".").last,
    index: index
  }
end

def test
  input = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

  expected = "Krakow02.jpg
London1.png
Krakow01.png
Florianopolis2.jpg
Florianopolis1.jpg
London2.jpg
Florianopolis3.png
Krakow03.jpg
Krakow09.png
Krakow07.jpg
Krakow06.jpg
Krakow08.jpg
Krakow04.png
Krakow05.png
Krakow10.jpg"

  output = solution(input)
  puts "expected\n#{expected} to equal\n#{output}"
  if expected == output
    puts "TEST PASSED"
  else 
    puts "TEST FAILED"
  end
end

test if __FILE__ == $0