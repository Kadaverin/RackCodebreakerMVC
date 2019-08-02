# //
class HomeController < Rackgame::Controller
  def index
    @attempts_amount = Codebreaker::ATTEMPTS_AMOUNT
    @hints_amount = Codebreaker::HINTS_AMOUNT
  end
end
