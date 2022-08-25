# coding: utf-8
require 'homebus'
require 'homebus/state'

require 'open-uri'
require 'nokogiri'

class HomebusMultnomahBurnStatus::App < Homebus::App
  DDC = 'org.homebus.experimental.burn-status'

  URL = 'https://www.multco.us/health/staying-healthy/wood-burning-restrictions'

  def initialize(options)
    @options = options
    super
  end

  def setup!
    @device = Homebus::Device.new(name: 'Multnomah County burn status',
                                  manufacturer: "Homebus",
                                  model: 'Burn Status',
                                  serial_number: 'Multnomah'))
    end
  end

  def _find(spans)
    spans.each do |span|
      if span.text.match /^Today’s Burn Status - (\w+)/
        return $1
      end
    end

    return nil
  end

  def _scrape
    html = URI.open(URL)

    doc = Nokogiri::HTML(html)
    spans = doc.css('span')
    status = _find(spans)

    return status
  end

  def work!
    results = _scrape

    if results
      payload = {
        status: results
      }

      if @options[:verbose]
        puts payload
      end

      @device.publish! DDC, payload
    end

    sleep update_interval
  end

  def update_interval
    60 * 60 * 4
  end

  def name
    'Multnomah County burn status'
  end

  def publishes
    [ DDC ]
  end

  def devices
    @devices
  end
end
