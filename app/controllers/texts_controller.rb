class TextsController < ApplicationController
  before_filter :authorize
  require 'csv'

  def new
    @texts = Text.new
  end

  def create
    file = params['text']['texts_csv']
    @csv = CSV.parse(file.read)

    if @csv.first.count < 5 
      flash[:error] = t('texts.invalid_file')
      redirect_to new_text_path
    elsif
      @csv.each do |text|
        new_text = Text.new
        new_text.sent_received = text[0]
        new_text.timestamp     = text[1]
        new_text.contacts      = text[2]
        new_text.numbers       = text[3]
        new_text.message       = text[4]
        new_text.save
      end

      flash[:notice] = t('texts.successful_upload')
      redirect_to root_url
    end
  end

  def destroy_all
    Text.destroy_all
    flash[:notice] = t('texts.successful_deletion')
    redirect_to root_url
  end
end
