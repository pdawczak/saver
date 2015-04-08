class App::PagesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_recent_pages_of_current_user, only: [:index, :create]

  def index
    @page = Page.new
  end

  def create
    @page = current_user.pages.build(page_params)

    if @page.save
      redirect_to app_url, notice: %Q<"#{@page.title}" has been saved!>
    else
      render :index
    end
  end

  private

  def page_params
    params.require(:page).permit(:url, :title, :description)
  end

  def set_recent_pages_of_current_user
    @pages = current_user.recent_pages(5)
  end
end
