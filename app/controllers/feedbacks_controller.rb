# -*- coding: utf-8 -*-
class FeedbacksController < ApplicationController

  before_action :basic_auth, only: [:index]

  def index
    @feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to :new_feedback, notice: 
      'ご意見ありがとうございました。送信しました'
    else
      redirect_to :new_feedback, alert: 'お名前とご意見を入力して下さい'
=begin
      flash.now[:alert] = "名前とご意見を入力して下さい"
      render :action => :new
=end

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
