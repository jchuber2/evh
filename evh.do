// written by Chuck Huber on 09oct2020
// email: chuber@stata.com
// Twitter: @StataChuck
// Examples of evh.ado

version 16

// Define global macros for graph dimensions
global Width4x4   = 1080*2
global Height4x4  = 1080*2


evh
graph export evh.png, as(png) width($Width4x4) height($Height4x4) replace

evh, bcolor(red) numlines(20) rseed(5150)
graph export evh_red_20_5150.png, as(png) ///
             width($Width4x4) height($Height4x4) replace

evh, bcolor(white) numlines(12) rseed(1984)
graph export evh_white_12_1984.png, as(png) ///
              width($Width4x4) height($Height4x4) replace
              
evh, bcolor(black) numlines(10) rseed(1)
graph export evh_black_10_1.png, as(png) ///
              width($Width4x4) height($Height4x4) replace
              
              