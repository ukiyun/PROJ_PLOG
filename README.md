# Traxit Board Game

## Team Members

Group Traxit_1

- Daniel Pinto (up202108808)
- Mariana Conde (up202108824)

## Game Picked :

##  <p style="text-align: center;">[TRAXIT](https://boardgamegeek.com/boardgame/392652/traxit) </p>


## Getting Started

1. Install a Prolog Interpreter / Compiler, e.g, from the [SICStus Website](https://sicstus.sics.se/download4.html) by following the provided instructions.

2. Once the Interpreter is installed, download the zipped folder containing the game files, and unzip it.
<br>
<br>



<p float="center">
  <img src="https://www.guru99.com/images/3/download-files-from-github-9.png" width="300" />
  <img src="https://allthings.how/content/images/wordpress/2021/08/allthings.how-how-to-unzip-files-in-windows-11-image.png" width="400" />
</p>

<br>
<br>

## Installing the Game

- To install it, just compile the file menu.pl in the Prolog Interpreter, every other file should be loaded automatically.

<br>

## Starting the Game

- In the Compiler, just type :

```prolog
?- play.
```
- **NOTE** : each time you input an instruction or move in the interpreter, don't forget to end the phrase always with a *full stop* !

- The rest of the game is rather intuitive, just follow along the instructions provided.

<br>

## Game Description

- Traxit is an abstract board game where your main goal is to have your pawn stay as close to the top as possible, in the rounds that matter.


### The Board
- The board is an 8 x 8, where each layer / level is worth a different amount of points.



```prolog
     |---|---|---|---|---|---|---|---| 
     | X | X | X | X | X | X | X | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | O | O | O | O | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | W | W | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | A | A | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | A | A | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | W | W | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | O | O | O | O | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | X | X | X | X | X | X | X | 
     |---|---|---|---|---|---|---|---| 
```

<br>

- **X's** are worth 0 points

- **O's** are worth 25 points

- **W's** are worth 50 points

- **A's** are worth 100 points


### Cards

- Each Player has 2 pawns and a total of 12 different path tiles.
- These tiles are unique and you can rotate the path as freely as you'd like.
- After using a Path, the corresponded tile is discarded.

### Score & Rounds 

- There are a total of 12 rounds and at the end of every 4 rounds (4, 8, 12) you score points based on the position of both your pawns.

- You can't move outside the board, and if you can't move at all, the opponent takes one of your pawns and moves it to the lowest level. This move is called a ***Traxit***, which is the latin word for being pulled.

- At the end of all rounds, the points are tallied up and the person with the highest score wins!