class StaticPagesController < ApplicationController
  def show
    @page = StaticPage.find_by(title: params[:title])
    if @page.nil?
      render plain: "Page not found", status: :not_found
    end
  end
end
