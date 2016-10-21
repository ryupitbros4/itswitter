class FeedbacksController < ApplicationController

  def index
    @feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to :feedbacks
    else
      render 'new'
    end
  end

  def edit
    @feedback = Feedback.find(params[:id])
    @feedback.archive = !@feedback.archive
    if @feedback.save
      redirect_to :feedbacks
    else
      render 'edit'
    end
  end

  private

  def feedback_params
    params[:feedback].permit(:name, :opinion)
  end

end
