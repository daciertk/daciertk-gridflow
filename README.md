# GridFlow Programming
GridFlow is a terminal spreadsheet program and programming language. GridFlow was developed as part of CS 430 - Programming Languages taught by Chris Johnson at JMU. GridFlow is written in Ruby with Curses graphics library to construct the interface. GridFlow supports entering and saving mathmatical expressions in cells,
and statistical functions mean, median, max and min over a set of cells. A writeup and demonstration of GridFlow is available [here on my personal website](https://daciertk.github.io/projects/gridflow.html)

## Running GridFlow
Running GridFlow requires Ruby and the [Curses gem](https://rubygems.org/gems/curses/versions/1.2.4) to be installed. From the project folder run **ruby interfacemain.rb**

## Formal Language Definition
GridFlow has a formal language definition written in EBNF form. This grammar is followed closely by the parser to build the executable program and can be found in grammar.txt

## GridFlow commands
The GridFlow interface features 4 subwindows: A 2d grid with columns and rows showing the value most recently evaluated to each cell, a formula editor, the selected cells value, and the row/column coordinate of the cell. The user selects a cell by moving around with the arrow keys. To enter an expression into a cell, press Tab and the formula editor opens for the selected cell, pressing Enter evaluates the expression and stores it into the cell.

## Cell Values, Variables, and Functions
GridFlow allows the sharing of data across cells. Entering the # character followed by the coordinate in brackets evaluates to the value stored in that cell. Here is an example of using the value stored at Row 2, Column 1
> #[2,1] + 3

Variables can be created at any time and they are shared among all cells. Variables are created and accessed using the ':' character followed by an identifier. The following is an example of creating and using a variable in GridFlow
> :var = 3
> 
> 3 + :var

GridFlow supports 4 functions: Max, Min, Sum, Mean. Each function operates over a range of cells. To use these functions, use the top left and bottom right cell addresses of the range of cells
> max(#[0,0], [3,2])

