# latex-test

A simple unit test for my latex doc

## Requires

- `testunit`(not gem)

## Test Cases

All comment parts are ignored before testing.

  -  are the labels correspond refs
  -  does figure contain 'label' definition
  -  does figure contain 'caption' definition
  -  is the figure caption placed correct position
  -  is the figure centeringed
  -  does table contain 'label' definition
  -  does table contains 'caption' definition
  -  is the table caption been placed correct position
  -  is the table centeringed
  -  has the document wrote with section
  
## Run
terminal:
```
% ruby latex-test.rb input.tex
```
