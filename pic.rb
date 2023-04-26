result_folder = ARGV[0]
Dir.mkdir(result_folder) unless File.exists?(result_folder)

def pic content, book, result_folder

  x = 1
  counter = 1
  until (x > content.length)do
    counter += 1
    x = counter*counter
  end

  # book_filename = book + rand(1..100).to_s

  # p book_filename 

  # p content
  # p result_folder
  # color = sample_color
  color = "DarkSlateGray"
  content_label = content.scan(/.{1,#{(counter + 1).to_s}}/).join("\n")
  # %x(convert -background lightblue -fill blue \
  #         -font './1218.otf' -pointsize 72 label:"#{content}" \
  #         label.gif)
  begin
    %x(convert -font './1218.otf' -size 2048x150 -gravity NorthWest -background #{color} -fill white label:"醬即興讀 r.flyism.org #{book}" "#{result_folder}/#{book}.jpg")
  rescue
    p "error"
  end

  sleep 1

  begin
    %x(convert \
    -font './1218.otf' \
    -size 2048x2048 \
    -gravity NorthWest \
    -background #{color} \
    -fill white \
    -border 400x400 \
    -bordercolor #{color} \
    label:"#{content_label}" \
    -draw "image over 400,250,2048,150 './#{result_folder}/#{book}.jpg'" \
    "./#{result_folder}/#{content[0..10]}.jpg")
  rescue
    p "error2"
  end
end

def sample_color
  colors = %w(DarkGreen navy NavyBlue green DarkRed red4 blue4 DarkBlue green4 MidnightBlue OrangeRed4 firebrick4 red3 indigo blue3 MediumBlue DarkSlateGray DarkSlateGrey green3 ForestGreen SpringGreen4 chartreuse4 DarkOrange4 brown4 chocolate4 SaddleBrown DeepPink4 orange4 tomato4 DodgerBlue4 red2 blue2 green2 DarkOliveGreen RoyalBlue4 DeepSkyBlue4 firebrick DarkGoldenrod4 sienna4 coral4 brown purple4 MediumForestGreen red)
  colors.sample
end

require 'csv'
CSV.foreach("#{result_folder}.csv", headers: true ) do |line|
  pic line[0], line[1], result_folder
end



