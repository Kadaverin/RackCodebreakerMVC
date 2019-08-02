# /
class ScoreController < Rackgame::Controller
  def ask_for_save
    @won = request.session['game'].won?
  end

  def save
    game = request.session['game']

    Score.create(
      status: game.won?,
      user_name: request.params['user_name'],
      used_attempts: game.used_attempts,
      used_hints: game.used_hints
    )

    redirect('/score_list')
  end

  def score_list
    @score_list = Score.all
  end
end
