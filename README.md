# Advent of Code 2024
This repository contains my solutions for [Advent of Code 2024](https://adventofcode.com/2024). This year I decided to try a new programming language that sounded neat: [nim](https://nim-lang.org/documentation.html) supposedly combines the ease of writing Python with better performance & type safety.

## Setup
I ran into several issues trying to install nim on my Windows PC, as the built-in antivirus was flagging the installer as a trojan. I got around this using WSL and following the Unix installation instructions instead.

## How to run
This will compile and run the selected `*.nim` file, as well as routing the compiled output to a `/bin` folder, and silencing the compilation hints:
`nim c -o:bin/day03 -r --hints:off ./src/day03.nim`