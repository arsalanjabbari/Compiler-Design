

# Compiler Design Project

## Introduction
In this project, we intend to design a compiler that reads arithmetic expressions and, in addition to computing the result of the expression according to the logic we define for it, generates three-address code in the C language.

## Important Notes
- Operator precedence and associativity are as usual.
- It is assumed that the input expression is free of compiler errors.
- The input arithmetic expression consists of integers (up to 10 digits), addition, subtraction, multiplication, division operators, parentheses, and white spaces.
- The operation of operators is as follows:
  - Expression a+b: digits of number b that are not in a are appended to the end of a.
  - Expression a-b: digits of number b that are in a are removed from a.
  - Expression a*b: the result digit of adding the digits of number b is appended to the end of a if it does not exist at the end of a.
  - Expression a/b: the result digit of adding the digits of number b is removed from a if it exists in a.

## Requirements
- Installing and adding to path << gcc - Flex - Bison >>
- The installation files mentioned are legally accessible from here https://sourceforge.net/projects/gnuwin32/ .

## Phase One - Lexical Analysis
  In this phase, lexical analysis was done with the help of FLex. As can be seen in the "phase_one.l" file, at the beginning (in the first segment) the necessary libraries, the declaration of the install_num function and a definition to convert the output of this phase into a type understandable for the Syntax-Analysis phase (conversion from int to (char*) string) are placed.
  
  After that, in the continuation of the Lex Specification, which is before the two %%, we will define Regular-Definitions.
  
  Then Translation-Rules had to be written between two %%, which is logically implemented.
  
  And finally, the install_num function is defined and implemented. It should be noted that in order to execute this phase, you must execute the command "flex phase_one.l" in the project directory, the output of which will be "lex.yy.c".

## Phase Two and Three - Syntax Analysis & Intermediate Code Generation
  In this phase, with the help of Bison, syntax analysis was done and then code generation was done to solve the problem of the project. As can be seen in the "phase_two_three.l" file, firstly, the necessary libraries, declaration of functions, definition for synchronizing the output of the previous phase and the input of the Syntax-Analysis phase (conversion from int to (char* (string)) and constant values required in Implementations have been placed.
  
  In the following, the intended grammar and its semantic actions are given in the form of ambiguity and compliance with the principles of associativity in the operators.
  
  Then, in the two functions plus_minus and mult_div, the implementation of the desired activity and performance of the project has been implemented.
  
  The sum_of_digits function is implemented as an auxiliary function to calculate the sum of digits!
  
  And finally, two functions three_code and finalize, according to the principles of intermediate code production and by maintaining the principles of memory allocation and timely removal of temporary variables, finally produce three-address code for us.
  
  It should be noted that in order to execute this phase, you must execute the command "bison -d -y phase_two_three.y" in the project directory, the output of which will be "y.tab.c" and "y.tab.h".
  
  Then by running "gcc y.tab.c lex.yy.c" the executable file is generated and finally by running "a.exe" you are allowed to enter the input you want.
