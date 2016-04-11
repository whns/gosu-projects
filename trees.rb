##
# "Recursion Trees" adapted for Ruby + Gosu (and interactivity)
# from Lode's Computer Graphics Tutorial
# http://lodev.org/cgtutor/recursiontrees.html
#

require 'rubygems'
require 'gosu'
require 'texplay'
include Math

class MyWindow < Gosu::Window
  pi = 3.1415926535897932384626433832795
  $w = 512  #width
  $h = 512  #height
  $saved_img = 1 #names saved images
  
  #default params:
  $maxRecursions = 6
  $angleValue = 0.2
  $angle = $angleValue * pi  #angle in radians
  $shrink = 1.8  #relative size of new branches 
  $inter = 0  #(optional) set to non-zero value to use as a fixed interval for angle + shrink calculations

  def initialize
    super($w, $h, false, 20)
    self.caption = 'recursion trees'
    @image = Gosu::Image.new(self, "black_sq_512.png")
    @color = Gosu::Color.new(0xff000000)
    @color.red = 128
    @color.green = 96
    @color.blue = 64
  end
  
  def update
    #Left arrow: decreases angle
    if button_down? Gosu::KbLeft
      @image = Gosu::Image.new(self, "black_sq_512.png")
      if $inter != 0 then
        $angle -= $inter
      else
        $angle -= rand() 
      end
      sleep 0.5
    end
    #Right arrow: increases angle
    if button_down? Gosu::KbRight then
      @image = Gosu::Image.new(self, "black_sq_512.png")
      if $inter != 0 then
        $angle += $inter
      else
        $angle += rand() 
      end
      sleep 0.5
    end
    #Down arrow: decreases shrink
    if button_down? Gosu::KbDown then
      @image = Gosu::Image.new(self, "black_sq_512.png")
      if $inter != 0 then
        $shrink -= $inter
      else
        $shrink -= rand() 
      end
      sleep 0.5
    end
    #Up arrow: increases shrink
    if button_down? Gosu::KbUp then
      @image = Gosu::Image.new(self, "black_sq_512.png")
      if $inter != 0 then
        $shrink += $inter
      else
        $shrink += rand() 
      end
      $shrink += rand() 
      sleep 0.5
    end
    #'S': saves window contents as .png
    if button_down? Gosu::KbS then
      @image.save('img_' + $saved_img.to_s + '.png')
      $saved_img += 1
      sleep 0.5
    end
    #'Esc': exit
    if button_down? Gosu::KbEscape then
      close
    end
  end

  def draw
    @image.draw 0,1,1
    recursion($w / 2, $h - 1, 0, -1, $h / 2.3, 0);
  end

  def recursion(posX, posY, dirX, dirY, size, n)
    x1 = posX.to_i
    y1 = posY.to_i
    x2 = (posX + size * dirX).to_i
    y2 = (posY + size * dirY).to_i
    draw_line(x1, y1, @color, x2, y2, @color)

    @image.paint {
      line x1, y1, x2, y2, @color
    }

    if(n >= $maxRecursions) then
      return
    end

    posX2 = posX + size * dirX;
    posY2 = posY + size * dirY;
    size2 = size / $shrink;
    n2 = n + 1;
    dirX2 = cos($angle) * dirX + sin($angle) * dirY;
    dirY2 = -sin($angle) * dirX + cos($angle) * dirY;
    recursion(posX2, posY2, dirX2, dirY2, size2, n2);
    dirX2 = cos(-$angle) * dirX + sin(-$angle) * dirY;
    dirY2 = -sin(-$angle) * dirX + cos(-$angle) * dirY;
    recursion(posX2, posY2, dirX2, dirY2, size2, n2);
  end
end

window = MyWindow.new
window.show
