#coding: utf-8

require "#{File.dirname(__FILE__)}/example_helper"

dice = "#{Prawn::BASEDIR}/data/images/dice.png"
Prawn::Document.generate "flowing.pdf" do
  # first, position an image that we'll flow around
  width = bounds.width / 2 - 18 # give us some padding on the left of the image
  info = image(dice, :width => width, :position => :right)

  # create the layout helper that we'll use to flow the text
  layout(DATA.read, :align => :justify) do |helper|
    # fill the first box
    y = helper.fill(bounds.left, bounds.top, width, :height => info.scaled_height + font_size - 1)

    # fill the rest
    self.y = helper.fill(bounds.left, y, bounds.width)
  end
end

__END__
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut neque. Maecenas scelerisque euismod purus. Nam venenatis. Sed velit mauris, cursus sit amet, semper vitae, sagittis quis, tortor. Nam at nisi. Sed ac nibh. Curabitur auctor ipsum nec tellus. Suspendisse potenti. Morbi dapibus magna a velit. Ut fringilla enim eu enim. Quisque lacinia, arcu dignissim gravida semper, eros quam tempor nisi, non scelerisque massa odio ut mi. Nullam ac ipsum. Proin volutpat tristique sem. Sed ipsum felis, volutpat vel, porttitor id, volutpat eu, mauris. Cras eget nulla sit amet dolor cursus semper. Curabitur nulla nunc, accumsan sit amet, vestibulum sit amet, adipiscing in, lorem. Pellentesque sodales purus sit amet odio. Cras commodo. Nam accumsan. Suspendisse potenti. Fusce posuere neque in nulla. Ut cursus blandit nisl. Phasellus ut nulla quis nunc tempus consequat. In hac habitasse platea dictumst. Praesent molestie nisl nec erat. Vivamus pretium nibh sit amet est. Integer dolor. Sed dictum blandit purus. Quisque et mauris vel diam dictum dignissim. Maecenas ultrices. Cras leo risus, tristique quis, hendrerit eu, condimentum tempor, mi. Nullam consectetur ante non nisl. Nulla dignissim sem in turpis. Cras purus felis, molestie ac, rhoncus sed, suscipit et, nisl. Donec tempus justo eu turpis. Aenean quis diam at dolor interdum tempor. Mauris sed nulla vitae erat lobortis lacinia. Nunc mauris. Aliquam mattis egestas ligula. Morbi magna dolor, convallis id, interdum lacinia, pellentesque eu, velit. In non arcu. Duis a nibh. Vestibulum volutpat erat et magna. Vivamus mi ante, aliquam et, vulputate sit amet, pretium non, ligula. Curabitur elementum, nisl ut gravida placerat, nisl sapien posuere augue, a placerat urna enim in velit. Cras nisi. Suspendisse volutpat. Ut eu lorem sed eros sollicitudin volutpat. Quisque blandit, libero sed mattis scelerisque, elit turpis ultricies purus, quis faucibus orci erat quis sem. Vestibulum imperdiet facilisis ante. Mauris dignissim, arcu vitae tincidunt congue, ante nulla aliquam purus, a porta tellus nisl at lectus. Phasellus commodo lacus et tortor. Etiam tortor leo, scelerisque sit amet, lobortis non, gravida vitae, mi. Donec eget augue. Sed ultrices ipsum eget risus. Aliquam rhoncus arcu vitae orci pellentesque pulvinar. Praesent ornare, lacus eget elementum ultrices, massa justo dignissim massa, a suscipit elit nibh quis arcu. Aliquam non massa. Etiam pharetra nisi at risus. Donec felis turpis, suscipit a, luctus vulputate, lobortis id, neque. Proin vitae nibh. Pellentesque nibh risus, volutpat sollicitudin, lobortis vitae, malesuada eu, elit. Duis felis nulla, sagittis id, faucibus luctus, viverra id, eros. Phasellus vulputate leo eget libero. Ut ut ipsum ac dui accumsan placerat. Integer porttitor. Quisque gravida dolor eu diam. Phasellus sodales sem sit amet urna. Morbi ornare viverra mauris. 
