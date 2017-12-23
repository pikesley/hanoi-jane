require 'thor'
require 'httparty'

require 'hanoi/jane/version'
require 'hanoi/jane/towers'
require 'hanoi/jane/constrained_towers'
require 'hanoi/jane/matrix'
require 'hanoi/jane/console'

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
