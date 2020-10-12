// written by Chuck Huber on 09oct2020
// email: chuber@stata.com
// Twitter: @StataChuck
// Examples:
//    evh
//    evh, bcolor(red)
//    evh, bcolor(white)
//    evh, bcolor(black) rseed(5150) numlines(20)


capture program drop evh
program evh
    syntax [, bcolor(string) rseed(integer 5150) numlines(integer 12)]

    set seed `rseed'
    local numlines = round(`numlines'/2, 1.0)

    // Define the color schemes
    // =============================================================================
    if "`bcolor'" != "" & !inlist("`bcolor'", "white", "black", "red") {
        disp as error "bcolor must be white, black, or red"
        return
    }
    // Default is "red"
    if "`bcolor'" == "" {
        local bcolor "red"
    }
    if  "`bcolor'" == "red" {
        local BackgroundColor "red"
        local LineColor1 "black"
        local LineColor2 "white"
    }
    // Colors for white background    
    else if "`bcolor'" == "white" {
        local BackgroundColor "white"
        local LineColor1 "black"
        local LineColor2 "black"
    }
    // Colors for black background
    else if "`bcolor'" == "black" {
        local BackgroundColor "black"
        local LineColor1 "yellow"
        local LineColor2 "yellow"
    }

         

    // Create the graph commands
    // =============================================================================
    // random y
    forvalues i = 1/`numlines' {
        local y1 = rbeta(0.98, 0.98)
        local x1 = 0
        local y2 = rbeta(0.98, 0.98)
        local x2 = 1
        local RandColor = runiform()
        local LineColor = cond(`RandColor' < 0.5,"`LineColor1'", "`LineColor2'")
        local NumV = runiformint(0,3)
        local LineWidth = "v"*`NumV' + "thick"
        local newline " (pci `y1' `x1' `y2' `x2', lcolor(`LineColor') lwidth(`LineWidth')) "
        local evhlines "`evhlines' `newline'"
    } 
    // random x
    forvalues i = 1/`numlines' {
        local x1 = rbeta(0.98, 0.98)
        local y1 = 0
        local x2 = rbeta(0.98, 0.98)
        local y2 = 1
        local RandColor = runiform()
        local LineColor = cond(`RandColor' < 0.5,"`LineColor1'", "`LineColor2'")
        local NumV = runiformint(0,3)
        local LineWidth = "v"*`NumV' + "thick"
        local newline " (pci `y1' `x1' `y2' `x2', lcolor(`LineColor') lwidth(`LineWidth')) "
        local evhlines "`evhlines' `newline'"
    }       


    // Create the graph
    // =============================================================================
    #delimit ;
    twoway (pci 0 0 1 1,   lcolor(`BackgroundColor') lwidth(vvvthick) lpattern(solid))
           (pci 1 0 0 1,   lcolor(`BackgroundColor')   lwidth(vvvthick) lpattern(solid))
           (pci 0.2 0 0 1, lcolor(`LineColor2') lwidth(vvvthick) lpattern(solid))
           (pci 0.8 0 0.4 1, lcolor(`LineColor1') lwidth(vvvthick) lpattern(solid))
           (pci 0.4 0 0.7 0.3, lcolor(`LineColor1') lwidth(vvvthick) lpattern(solid))
           `evhlines'
          , yscale(off) 
            ylabel(none, nolabels noticks nogrid) 
            xscale(off) 
            xlabel(none, nolabels noticks nogrid) 
            graphregion(margin(zero) 
                        fcolor(`BackgroundColor') 
                       ifcolor(`BackgroundColor')) 
            plotregion(margin(zero)  
                       fcolor(`BackgroundColor') 
                      ifcolor(`BackgroundColor'))
            legend(off)
    ;
    #delimit cr
end
