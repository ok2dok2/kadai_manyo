class LabelsController < ApplicationController
  
  def index
    @labels = Label.all
    @label = Label.new
  end
  
  def new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, notice: 'タグを作成しました'
    else
      @labels = Label.all
    end
  end

  private
    def label_params
      params.require(:label).permit(:title)
    end
end
