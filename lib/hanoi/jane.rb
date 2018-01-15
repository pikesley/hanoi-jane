require 'singleton'
require 'yaml'
require 'ostruct'

require 'thor'
require 'httparty'

require 'hanoi/jane/version'

require 'hanoi/jane/config'

require 'hanoi/jane/towers'
require 'hanoi/jane/constrained_towers'
require 'hanoi/jane/animation'

require 'hanoi/jane/formatters/matrix'
require 'hanoi/jane/formatters/console'

module Hanoi
  module Jane
    def self.hit_phat towers, phat
      url = "http://#{phat}/lights"
      payload = {
        matrix: towers.matrix
      }
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      HTTParty.patch(url, body: payload.to_json, headers: headers)
    end
  end
end
