import Tkinter, random
from ..Sims.game import *

dim = 50
depth = 2
level = dim // 2
squareWidth = 10
canvasWidth = dim * squareWidth
payoff = [[0,2,0],[0,0,2],[2,0,0]]
colors = ["#f91b23", "#00a33d", "#3131cd"] #rgb
g = Game(payoff, 2, dim, freqs = [1,0,1])
running = False

theWindow = Tkinter.Tk()
theWindow.title("Moran Model")
theWindow.geometry('+50+50')  

theCanvas = Tkinter.Canvas(theWindow, width = canvasWidth, height = canvasWidth)
theCanvas.pack()
theImage = Tkinter.PhotoImage(width = canvasWidth, height = canvasWidth)
theCanvas.create_image((3,3), image = theImage, anchor = "nw", state = "normal")

def startStop():
    global running
    running = not running
    if running:
        goButton.config(text="Pause")
    else:
        goButton.config(text="Resume")

# Create the GUI controls:
controlFrame = Tkinter.Frame(theWindow)        # a frame to hold the GUI controls
controlFrame.pack()                            # put it below the canvas
spacer = Tkinter.Frame(controlFrame, width=40)
spacer.pack(side="left")
goButton = Tkinter.Button(controlFrame, text="Start", width=8, command=startStop)
goButton.pack(side="left")


def colorSquare(point):
    theColor = colors[g.board.access(point)]
    x,y = point
    theImage.put(theColor, to=(x*squareWidth,y*squareWidth,(x+1)*squareWidth,(y+1)*squareWidth))


def simulate():
    if running:
        for step in range(1000):
            [r,val] = g.update()
            colorSquare(r)
    theWindow.after(1,simulate)

for (point,value) in g.board.iter():
    print(point)
    colorSquare(point)

simulate()
theWindow.mainloop() 
