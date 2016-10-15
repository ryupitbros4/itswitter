class ApplyPageController < ApplicationController
  def index
    @apply = Apply.new
    @applies = Apply.all.order(id: :desc)
  end

  def new
    @apply = Apply.new(params.require(:apply).permit(:apply_restaurant, :free))
    if @apply.save
      redirect_to :apply_page_index
    else
      @applies = Apply.all.order(id: :desc)
      render 'index'
    end

  end

end
