class TextsController < ApplicationController
  before_filter :authorize

  def new
    @texts = Text.new
  end

  def create

  end
end
