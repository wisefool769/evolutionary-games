import Tkinter, random
from game import *

dim = 10
level = dim // 2
squareWidth = 10
canvasWidth = size * squareWidth
payoff = [[1,0],[0,1]]
colors = ["#f91b23", "#00a33d", "#3131cd"] #rgb
g = Game(payoff, dim)

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

def colorSquare(i, j):
    theColor = colors[g.board.access([i,j,level])]
    theImage.put(t)


def simulate():
    if running:
        for step in range(1000):
            g.update()
            eDiff = deltaE(i,j)
            if eDiff <= 0 or random.random() < math.exp(-eDiff/T):    # Metropolis!
                s[i,j] = -s[i,j]
                colorSquare(i, j)
    theWindow.after(1,simulate)   
