class LessonsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
     @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def update
    @lesson = Lesson.find(params[:id])

    if @lesson.update_attributes(params[:lesson])
      redirect_to @lesson, notice: 'Lesson was successfully updated.'
    else
      render action: "edit"
    end
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(params[:lesson])

    if @lesson.save
      redirect_to @lesson, notice: 'Lesson was successfully created.' 
    else
      render action: "new"
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy

    redirect_to lessons_url
  end

end
