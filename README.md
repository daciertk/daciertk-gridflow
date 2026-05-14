# GridFlow Programming
GridFlow is a terminal spreadsheet program and programming language. GridFlow was developed as part of CS 430 - Programming Languages taught by Chris Johnson at JMU. GridFlow is written in Ruby with Curses graphics library to construct the interface. GridFlow supports entering and saving mathmatical expressions in cells,
and statistical functions mean, median, max and min over a set of cells. A writeup and demonstration of GridFlow is available [here on my personal website]([daciertk.github.io/projects/gridflow.html](https://daciertk.github.io/projects/gridflow.html))

## Running GridFlow
Running GridFlow requires Ruby and the [Curses gem](https://rubygems.org/gems/curses/versions/1.2.4) to be installed. From the project folder run **ruby interfacemain.rb**

## GridFlow commands
The GridFlow interface features 4 subwindows: A 2d grid with columns and rows showing the value most recently evaluated to each cell, a formula editor, the selected cells value, and the row/column coordinate of the cell. The user selects a cell by moving around with the arrow keys. To enter an expression into a cell, press Tab and the formula editor opens for the selected cell, pressing Enter evaluates the expression and stores it into the cell.
