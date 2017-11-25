[![Build Status](http://img.shields.io/travis/pikesley/hanoi-jane.svg?style=flat-square)](https://travis-ci.org/pikesley/hanoi-jane)
[![Dependency Status](http://img.shields.io/gemnasium/pikesley/hanoi-jane.svg?style=flat-square)](https://gemnasium.com/pikesley/hanoi-jane)
[![Coverage Status](http://img.shields.io/coveralls/pikesley/hanoi-jane.svg?style=flat-square)](https://coveralls.io/r/pikesley/hanoi-jane)
[![Gem Version](http://img.shields.io/gem/v/hanoi-jane.svg?style=flat-square)](https://rubygems.org/gems/hanoi-jane)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://pikesley.mit-license.org)

# Hanoi Jane

_Counting in binary to solve the Towers of Hanoi_

## Surely there are easier ways to do this?

Yes, there are. This is very much a Solved Problem. However, I was inspired to implement this solution after watching [3 Blue 1 Brown](https://www.youtube.com/channel/UCYO_jab_esuFRV4b17AJtAw)'s [fascinating video](https://www.youtube.com/watch?v=2SUvWfNJSsM), in which Grant relates the Towers Of Hanoi to the Rhythm Of Counting In Binary:

[![Screenshot](https://i.imgur.com/mXsl57y.png)](https://www.youtube.com/watch?v=2SUvWfNJSsM)

## Running it

    bundle
    bundle exec rake
    bundle exec rake install
    hanoi console

(or just `gem install hanoi-jane`, of course)

## Constrained version

There is a [constrained variant of the problem](https://www.youtube.com/watch?v=bdMfjfT0lKk), with the restriction that a disc may only move to an adjacent stack. I've also implemented the solution for this (which maps to the Rhythm Of Counting In Ternary) - you can run this with

    hanoi --constrained

## API

To use it in your own code, try something like:

```ruby
require 'hanoi/jane'

towers = Hanoi::Jane::ConstrainedTowers.new 2
towers.each do |state|
  puts state.inspect
end
```

which will give you:

```ruby
{:stacks=>[[1, 0], [], []], :moves=>0, :flipped=>nil, :ternary=>'00'}
{:stacks=>[[1], [0], []], :moves=>1, :flipped=>0, :ternary=>'01'}
{:stacks=>[[1], [], [0]], :moves=>2, :flipped=>0, :ternary=>'02'}
{:stacks=>[[], [1], [0]], :moves=>3, :flipped=>1, :ternary=>'10'}
{:stacks=>[[], [1, 0], []], :moves=>4, :flipped=>0, :ternary=>'11'}
{:stacks=>[[0], [1], []], :moves=>5, :flipped=>0, :ternary=>'12'}
{:stacks=>[[0], [], [1]], :moves=>6, :flipped=>1, :ternary=>'20'}
{:stacks=>[[], [0], [1]], :moves=>7, :flipped=>0, :ternary=>'21'}
{:stacks=>[[], [], [1, 0]], :moves=>8, :flipped=>0, :ternary=>'22'}
```
where `flipped` is the disc that was moved last

## pHAT

In order to over-engineer this, I've wrapped a [very thin Flask app](https://github.com/pikesley/pHAT-REST) around the [MicroDot pHAT](https://shop.pimoroni.com/products/microdot-phat). Try

    hanoi phat --phat <address_of_your_pi> --constrained

to watch this all [play out on the pHAT](https://www.youtube.com/watch?v=PAQY5XtdNO8):

[![Video](https://i.imgur.com/QILZYgx.png)](https://www.youtube.com/watch?v=PAQY5XtdNO8)
