require 'singleton'
require 'yaml'
require 'ostruct'

require 'thor'
require 'httparty'

require 'hanoi/jane/version'

require 'hanoi/jane/config'

require 'hanoi/jane/towers/stack_finders'
require 'hanoi/jane/towers/towers'
require 'hanoi/jane/towers/constrained_towers'
require 'hanoi/jane/towers/animated_towers'

require 'hanoi/jane/animation/animation'
require 'hanoi/jane/animation/lifter'
require 'hanoi/jane/animation/dropper'
require 'hanoi/jane/animation/padded_stacks'

require 'hanoi/jane/formatters/matrix'
require 'hanoi/jane/formatters/console'

module Hanoi
  module Jane
    def self.hit_phat stacks, value, phat
      matrix = Formatters::Matrix.new do |m|
        m.stacks = stacks
        m.digits = value
      end
      matrix.populate

      url = "http://#{phat}/lights"
      payload = {
        matrix: matrix
      }
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      HTTParty.patch(url, body: payload.to_json, headers: headers)
    end
  end
end
