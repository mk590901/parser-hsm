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

## Update

## Latest Movie

https://github.com/user-attachments/assets/c0eaeb54-93be-4c71-9fe0-725cf33979f0



