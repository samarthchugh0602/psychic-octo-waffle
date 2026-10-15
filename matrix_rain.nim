# File: matrix_rain.nim
# Language: Nim
# Run with: nim r -d:release matrix_rain.nim

import os, random

const
  Width = 70
  Height = 22
  Chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@#$%^&*"

type
  Drop = object
    x, y, length: int

proc main() =
  randomize()
  stdout.write("\e[2J\e[?25l") # Clear terminal screen and hide cursor

  var drops: seq[Drop] = @[]
  for _ in 0 ..< 25:
    drops.add(Drop(
      x: rand(0 ..< Width),
      y: rand(0 ..< Height),
      length: rand(5 .. 12)
    ))

  while true:
    for d in drops.mitems:
      let tailY = d.y - d.length
      if tailY >= 0 and tailY < Height:
        stdout.write("\e[" & $(tailY + 1) & ";" & $(d.x + 1) & "H ")

      if d.y >= 0 and d.y < Height:
        let ch = Chars[rand(0 ..< Chars.len)]
        stdout.write("\e[" & $(d.y + 1) & ";" & $(d.x + 1) & "H\e[32m" & $ch & "\e[0m")

      d.y += 1
      if d.y - d.length > Height:
        d.y = 0
        d.x = rand(0 ..< Width)

    stdout.flushFile()
    sleep(50)

main()
