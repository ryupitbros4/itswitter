class ApplyPageController < ApplicationController
  def index
    @apply = Apply.new
    @applies = Apply.all
  end

  def new
    @apply = Apply.create(params.require(:apply).permit(:apply_restaurant, :free))
    redirect_to :apply_page_index
  end

end
