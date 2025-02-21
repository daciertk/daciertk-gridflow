require_relative "html.rb"
tag = Html.make_tag('img', {src: 'bernie.jpg'}, :empty) 
tag2 = Html.make_tag('div', {id: 'root', class: 'frame'}, :sandwich) 
tag3 = Html.make_tag('Gallery', {}, :selfclose)
tag4 = Html.make_tag('head', {src: "/other/folder/html.html", class: "new class"}, :sandwich) 
puts tag
puts tag2
puts tag3
puts tag4