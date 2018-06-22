# /
class ScoreController < Rackgame::Controller
  def ask_for_save
    @won = request.session['game'].won?
  end

  def save
    # save score to yaml
    redirect('/score_list')
  end

  def score_list
    #print all history
  end
end
