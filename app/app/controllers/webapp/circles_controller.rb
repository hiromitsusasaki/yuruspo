class Webapp::CirclesController < ApplicationController
  
  before_action :authenticate
  
  def new
    @contents = [
      'フットサル',
      'バスケ',
      'バレー',
      '野球',
      'バドミントン',
      'テニス',
      'その他'
    ]
  end
end
