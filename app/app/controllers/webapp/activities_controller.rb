class Webapp::ActivitiesController < ApplicationController
  
  def new
    @circle = Circle.find(params[:circle_id])
    @months = months
    @days = days
    @hours = hours
    @minutes = minutes
  end

  private
    def months 
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    end

    def days
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
      11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
      21, 22, 23, 24, 25, 26, 27, 28, 29, 30 ,31]
    end

    def hours
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
    end

    def minutes
      [0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    end

  

end
