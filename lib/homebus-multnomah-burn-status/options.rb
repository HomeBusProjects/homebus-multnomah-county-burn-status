require 'homebus/options'

class HomebusMultnomahBurnStatus::Options < Homebus::Options
  def app_options(op)
  end

  def banner
    'Homebus OHA Monkeypox stats'
  end

  def version
    HomebusMultnomahBurnStatus::VERSION
  end

  def name
    'homebus-oha-monkeypox'
  end
end
