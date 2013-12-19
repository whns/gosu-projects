##
# "Sierpinski Carpet With Rectangle Recursion" adapted for Ruby + Gosu
# from Lode's Computer Graphics Tutorial
# http://lodev.org/cgtutor/sierpinski.html
#

require 'rubygems'
require 'gosu'

class MyWindow < Gosu::Window
	$c1 = 0xff00ffff #color: aqua
	$c2 = 0xff00ff00 #color: green
	$c3 = 0xff00ffff #color: cyan
	$c4 = 0xff00ffff #color: aqua
	$depth = 1

	def initialize
		super(729, 729, false)
		self.caption = 'sierpinski carpet'
	end

	def update
		#Press the left arrow key to decrease depth
		if button_down? Gosu::KbLeft and $depth > 1 then
			$depth -= 1
			sleep 0.5
		end
		#Press the right arrow key to increase depth
		if button_down? Gosu::KbRight then
			$depth += 1
			sleep 0.5
		end
	end

	def draw
		w=729 #width
		h=729 #height
		drawCarpet(1, 0, 0, w-1, h-1)
	end

	def drawCarpet(n, x1, y1, x2, y2)
		#draw center rectangle
		draw_quad(
			(2 * x1 + x2) / 3.0,
			(2 * y1 + y2) / 3.0,
			$c1,
			(2 * x1 + x2) / 3.0,
			(y1 + 2 * y2) / 3.0 - 1,
			$c2,
			(x1 + 2 * x2) / 3.0 - 1,
			(2 * y1 + y2) / 3.0,
			$c3,
			(x1 + 2 * x2) / 3.0 - 1,
			(y1 + 2 * y2) / 3.0 - 1,
			$c4)
		#recursive calls to draw the eight surrounding rectangles
		if(n < $depth)
	        drawCarpet(n + 1, x1                 , y1                 , (2 * x1 + x2) / 3.0, (2 * y1 + y2) / 3.0)
	        drawCarpet(n + 1, (2 * x1 + x2) / 3.0, y1                 , (x1 + 2 * x2) / 3.0, (2 * y1 + y2) / 3.0)
	        drawCarpet(n + 1, (x1 + 2 * x2) / 3.0, y1                 , x2                 , (2 * y1 + y2) / 3.0)
	        drawCarpet(n + 1,  x1                , (2 * y1 + y2) / 3.0, (2 * x1 + x2) / 3.0, (y1 + 2 * y2) / 3.0)
	        drawCarpet(n + 1, (x1 + 2 * x2) / 3.0, (2 * y1 + y2) / 3.0, x2                 , (y1 + 2 * y2) / 3.0)
	        drawCarpet(n + 1, x1                 , (y1 + 2 * y2) / 3.0, (2 * x1 + x2) / 3.0,  y2                )
	        drawCarpet(n + 1, (2 * x1 + x2) / 3.0, (y1 + 2 * y2) / 3.0, (x1 + 2 * x2) / 3.0,  y2                )
	        drawCarpet(n + 1, (x1 + 2 * x2) / 3.0, (y1 + 2 * y2) / 3.0, x2                 ,  y2                )
	    end
	end
end

window = MyWindow.new
window.show
