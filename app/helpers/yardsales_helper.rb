module YardsalesHelper
  def setup_yardsale(yardsale)
    yardsale.address ||= Address.new
    yardsale
  end
end
