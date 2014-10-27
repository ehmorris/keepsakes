class TextsController < ApplicationController
  before_filter :authorize
  require 'csv'

  def new
    @texts = Text.new
  end

  def create
    file = params['text']['texts_csv']
    @csv = CSV.parse(file.read)
  end
end
