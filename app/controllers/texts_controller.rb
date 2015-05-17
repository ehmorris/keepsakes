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
      all_records = []
      @csv.each do |text|
        all_records.push({
          :sent_received => text[0],
          :timestamp => Time.parse(text[1]).utc,
          :contacts => text[2].force_encoding("utf-8"),
          :numbers => text[3],
          :message => text[4].force_encoding("utf-8")
        })
      end

      Text.create(all_records) do |t|
        t.user_id = current_user.id
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
