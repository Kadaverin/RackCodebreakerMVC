# /
class GameController < Rackgame::Controller
  def index
    request.session['game'] = Codebreaker::Game.new
    request.session['hint'] = nil
    redirect('/game')
  end

  def game
    @game_history = session_game.history
    @attempts_left = session_game.attempts
    @hints_left = session_game.hints
    @hint = request.session['hint']
    redirect('/save_score') if game_over
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

  def game_over
    session_game.won? || @attempts_left.zero?
  end
end
