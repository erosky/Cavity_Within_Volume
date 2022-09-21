# This user-defined function gets called by OVITO to make it draw text and graphics on top of the viewport.
# The 'args' parameter provides various information such as the viewport being rendered and the target
# canvas the function should paint onto. Refer to the documentation of the ovito.vis.PythonViewportOverlay class 
# for further information.

from ovito.vis import *

def render(args: PythonViewportOverlay.Arguments):
    
    # This demo code prints the current animation frame into the upper left corner of the viewport.
    text1 = f"Frame {args.frame}"
    text2 = 235-args.frame*400*0.25*0.00001
    font = args.painter.font()
    font.setPixelSize(48)
    args.painter.setFont(font)
    args.painter.drawText(10, 10 + args.painter.fontMetrics().ascent(), str(text2))
    

