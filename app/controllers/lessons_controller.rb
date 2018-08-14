class LessonsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @lessons = Lesson.all
    end
  
    def show
      @lesson = Lesson.find(params[:id])
    end
  
    def new
      @lesson = current_user.lessons.build
    end
  
    def create
      @lesson = current_user.lessons.build(lesson_params)
      if @lesson.save
        redirect_to :back, notice: "レッスンを作成しました"
        # redirect_to edit_lesson_path(@lesson), notice: "レッスンを作成しました"
      else
        redirect_to new_lesson_path(@lesson), notice: "レッスンを作成できませんでした"
      end
    end
  
    def edit
      @lesson = Lesson.find(params[:id])
    end
  
    def update
      @lesson = Lesson.find(params[:id])
      if @lesson.update(lesson_params)
        redirect_to :back
      else
        
      end
  
    end
  
    private
    def lesson_params
      params.require(:lesson).permit(:title,:req_num,:summary,:content,:active)  
    end
  
  end
  