##
# "Sierpinski Triangles With Rectangle Recursion" adapted for Ruby + Gosu
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
	MAX = 8

	def initialize
		super(256, 256, false)
		self.caption = 'sierpinski triangles via rectangle recursion'
	end

	def update
		#Press the left arrow key to decrease depth
		if button_down? Gosu::KbLeft and $depth > 1 then
			$depth -= 1
			sleep 0.5
		end
		#Press the right arrow key to increase depth
		if button_down? Gosu::KbRight and $depth < MAX then
			$depth += 1
			sleep 0.5
		end
	end

	def draw
		w=256 #width
		h=256 #height
		drawSierpinski(1, 0, 0, w-1, h-1)
	end

	def drawSierpinski(n, x1, y1, x2, y2)
		draw_quad(
			(x1 + x2) / 2, y1, $c1,
			(x1 + x2) / 2, (y1 + y2) / 2 - 1, $c2,
			x2 - 1, y1, $c3,
			x2 - 1, (y1 + y2) / 2 - 1, $c4)

		if(n < $depth)
	        drawSierpinski(n + 1, x1, y1, (x1 + x2) / 2, (y1 + y2) / 2)
	        drawSierpinski(n + 1, x1, (y1 + y2) / 2, (x1 + x2) / 2, y2)
	        drawSierpinski(n + 1, (x1 + x2) / 2, (y1 + y2) / 2, x2, y2)
		end
	end
end

window = MyWindow.new
window.show
