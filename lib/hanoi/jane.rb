require 'singleton'
require 'yaml'

require 'thor'
require 'httparty'
require 'wiper'
require 'gitpaint'

require 'hanoi/jane/version'

require 'hanoi/jane/config'
require 'hanoi/jane/exceptions'

require 'hanoi/jane/towers/regular_towers'
require 'hanoi/jane/towers/constrained_towers'
require 'hanoi/jane/towers/animated_towers'

require 'hanoi/jane/animation/animation'
require 'hanoi/jane/animation/frame'
require 'hanoi/jane/animation/lifter'
require 'hanoi/jane/animation/dropper'
require 'hanoi/jane/animation/padded_stacks'
require 'hanoi/jane/animation/drop_in'
require 'hanoi/jane/animation/smoosher'

require 'hanoi/jane/formatters/matrix'
require 'hanoi/jane/formatters/console'
require 'hanoi/jane/formatters/github'

module Hanoi
  module Jane
    def self.render_to_github towers
      g = Formatters::Github.new towers
    end

    def self.render_to_phat source, interval, phat
      source.each do |frame|
        Hanoi::Jane.hit_phat frame.to_dots, phat
        sleep interval * interval_factor(frame)
      end
    end

    def self.hit_phat grid, phat
      url = "http://#{phat}/lights"
      payload = {
        matrix: grid
      }
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      HTTParty.patch(url, body: payload.to_json, headers: headers)
    end

    def self.render_to_console source, interval, fancy
      source.each do |frame|
        Hanoi::Jane.draw_console frame.stacks, frame.value, fancy
        sleep interval * interval_factor(frame)
      end
    end

    def self.draw_console stacks, value, fancy = false
      system('clear')

      c = Formatters::Console.new do |c|
        c.stacks = stacks
        c.fancy = fancy
      end

      puts value
      puts c
    end

    def self.interval_factor frame
      if frame.animtype == :tween
        return Config.instance.config.animation['tween-scale']
      end
      1
    end

    def self.scale size
      (size * 2) + 1
    end
  end
end
