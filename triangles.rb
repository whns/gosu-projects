##
# "Sierpinski Triangles" adapted for Ruby + Gosu
# from Lode's Computer Graphics Tutorial
# http://lodev.org/cgtutor/sierpinski.html
#

require 'rubygems'
require 'gosu'

class MyWindow < Gosu::Window

	$c1 = 0xff00ffff #color: aqua
	$c2 = 0xff00ff00 #color: green
	$depth = 1 #the initial number of recursive steps

	def initialize
		super(640, 480, false)
		self.caption = 'sierpinski triangles'
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
		w=640 #width
		h=480 #height
		drawSierpinski(10,h-10,w-10,h-10,w/2,10)
	end

	def drawSierpinski(x1, y1, x2, y2, x3, y3) 
		#Draw the 3 sides of the outer triangle, start recursion
		draw_line(x1,y1,$c1,x2,y2,$c2)
		draw_line(x1,y1,$c1,x3,y3,$c2)
		draw_line(x2,y2,$c1,x3,y3,$c2)
		subTriangle(
			1, #First Recursion
			((x1 + x2) / 2), #x coordinate of first corner
			((y1 + y2) / 2), #y coordinate of first corner
			((x1 + x3) / 2), #x coordinate of second corner
			((y1 + y3) / 2), #y coordinate of second corner
			((x2 + x3) / 2), #x coordinate of third corner
			((y2 + y3) / 2))  #y coordinate of third corner
	end

	def subTriangle(n, x1, y1, x2, y2, x3, y3) #Draws the upside-down, inner triangles
		draw_line(x1,y1,$c1,x2,y2,$c2)
		draw_line(x1,y1,$c1,x3,y3,$c2)
		draw_line(x2,y2,$c1,x3,y3,$c2)

		if(n < $depth) 
	        #Smaller triangle 1
	        subTriangle(
	        	(n+1), #Number of recursions for the next call increased with 1
	        	((x1 + x2) / 2 + (x2 - x3) / 2), #x coordinate of first corner
	        	((y1 + y2) / 2 + (y2 - y3) / 2), #y coordinate of first corner
	        	((x1 + x2) / 2 + (x1 - x3) / 2), #x coordinate of second corner
	        	((y1 + y2) / 2 + (y1 - y3) / 2), #y coordinate of second corner
	        	((x1 + x2) / 2), #x coordinate of third corner
	        	((y1 + y2) / 2)) #y coordinate of third corner
	        #Smaller triangle 2
	        subTriangle(
		        (n+1), #Number of recursions for the next call increased with 1
		        ((x3 + x2) / 2 + (x2 - x1) / 2), #x coordinate of first corner
		        ((y3 + y2) / 2 + (y2 - y1) / 2), #y coordinate of first corner
		        ((x3 + x2) / 2 + (x3 - x1) / 2), #x coordinate of second corner
		        ((y3 + y2) / 2 + (y3 - y1) / 2), #y coordinate of second corner
		        ((x3 + x2) / 2), #x coordinate of third corner
		        ((y3 + y2) / 2)) #y coordinate of third corner
	        #Smaller triangle 3
	        subTriangle(
		        (n+1), #Number of recursions for the next call increased with 1
		        ((x1 + x3) / 2 + (x3 - x2) / 2), #x coordinate of first corner
		        ((y1 + y3) / 2 + (y3 - y2) / 2), #y coordinate of first corner
		        ((x1 + x3) / 2 + (x1 - x2) / 2), #x coordinate of second corner
		        ((y1 + y3) / 2 + (y1 - y2) / 2), #y coordinate of second corner
		        ((x1 + x3) / 2), #x coordinate of third corner
		        ((y1 + y3) / 2)) #y coordinate of third corner        
		end
	end
end

window = MyWindow.new
window.show
