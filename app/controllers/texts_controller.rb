class TextsController < ApplicationController
  before_filter :authorize
  require 'csv'

  def new
    @texts = Text.new
  end

  def create
    file = params['text']['texts_csv']
    @field_names = ['sent_received',
                    'timestamp',
                    'contacts',
                    'numbers',
                    'message']
    @csv = CSV.parse(file.read)

    if @csv.first.count < @field_names.count
      flash[:error] = t('texts.invalid_file')
      redirect_to new_text_path
    end
  end
end
