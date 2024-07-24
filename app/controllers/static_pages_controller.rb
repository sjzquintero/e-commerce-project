# frozen_string_literal: true

# StaticPagesController manages the display of static pages within the application.
# These pages are typically content pages that do not change frequently, such as
# About Us, Contact, or Terms of Service.
class StaticPagesController < ApplicationController
  # Displays a static page based on the title provided in the parameters.
  # If the page is not found, it renders a plain text response indicating
  # that the page was not found, with a 404 status.
  def show
    @page = StaticPage.find_by(title: params[:title])
    return unless @page.nil?

    render plain: "Page not found", status: :not_found
  end
end
