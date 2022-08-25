require 'homebus/options'

class HomebusMultnomahBurnStatus::Options < Homebus::Options
  def app_options(op)
  end

  def banner
    'Homebus Multnomah County burn status'
  end

  def version
    HomebusMultnomahBurnStatus::VERSION
  end

  def name
    'homebus-multnomah-county-burn-status'
  end
end
