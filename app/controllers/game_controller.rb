# /
class GameController < Rackgame::Controller
  def index
    request.session['game'] = Codebreaker::Game.new
    request.session['hint'] = nil
    redirect('/game')
  end

  def game
    @attempts_left = session_game.attempts_left
    @hints_left = session_game.hints_left
    @game_history = session_game.history
    @hint = request.session['hint']
    redirect('/ask_for_save_score') if game_over
  end

  def hint
    request.session['hint'] = session_game.hint
    redirect('/game')
  end

  def guess
    session_game.answer_on(request.params['user_guess'])
    redirect('/game')
  end

  def session_game
    request.session['game']
  end

  # вынести в гем кодбрейкера, логика явно не для контроллера
  def game_over
    session_game.won? || @attempts_left.zero?
  end
end
