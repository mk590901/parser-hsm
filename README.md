# Parser-HSM

The application demonstrates the work of a lexical parser based on a __hierarchical state machine__.

## Introduction
A hierarchical state machine allows one to simplify the number of operations on text during lexical parsing of an arithmetic expression and replace the logic of lexeme detection by transitions from state to state under the action of events.

## State Machine
Below is the parser's hierarchical state machine, implement the processing of the source arithmetic expression and extract lexemes (tokens).

![hsm](https://github.com/user-attachments/assets/6e142156-34e8-4bea-9267-674a1c6b6659)

## Implementation HSM
ParserHelper is a set of transfer functions of the hierarchical state machine shown in the diagram above. This class is generated automatically by the HSM editor and developer only needs to comment out unnecessary transitions and add links to the parser functions inside the significant functions. By the way, the parser used is a copy of the __parser controller__ from the (https://github.com/mk590901/parser-fsm) project.

## Description of application
The application is a Flutter app with a predefined set of arithmetic expressions. They can be selected using a combo box and parsed by pressing the parse button. The result of parsing is a list of tokens indicating the type and classification.

## Note
Note. The two applications __Parser HSM__ and __Parser FSM__ (https://github.com/mk590901/parser-fsm) are made in the same style and from the GUI point of view are twin brothers. That is, they completely coincide except for the engine used. In fact, the main goal of these projects was the idea to show that the same tasks can be solved with both FSM and HSM. What exactly to choose is a matter of taste and sympathy of the developer.

## Movie

https://github.com/user-attachments/assets/06046be8-61e1-467d-99d3-47dd1c3f670d

## Updates

The application has been modified and supplemented

### Asynchronous processing of events.

The previous method synchronous processing of threaded code was replaced by of asynchronous processing inside __Runner__ class. This allowed solving the problem of hidden recursion when calling functions. The __StreamController__ class implements the mechanism of posting of events via the add event operation and processing this event in the listener, which listens for changes of __StreamController__.

### Transformation of an infix expression into a postfix one

Actually, parsing, implemented using __HSM__, represented by threaded code, was the purpose of the application. But now I decided to supplement parsing with the operation of transforming an infix expression into a postfix one, or into "Polish" notation. This is not the pure __Shunting Yard Algorithm__ [https://en.m.wikipedia.org/wiki/Shunting_yard_algorithm#:~:text=In%20computer%20science%2C%20the%20shunting,abstract%20syntax%20tree%20(AST)], but some modified version of it that allows detecting some errors.

## Latest Movie

https://github.com/user-attachments/assets/c0eaeb54-93be-4c71-9fe0-725cf33979f0



