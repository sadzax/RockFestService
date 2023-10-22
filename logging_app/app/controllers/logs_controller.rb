# frozen_string_literal: true

# Контроллер логов
class LogsController < ApplicationController
  before_action :set_log, only: %i[show edit update destroy]

  # GET /logs or /logs.json
  def index
    result = Log.all
    result = result.where(name: params[:name]) unless params[:name].nil?
    result = result.where(result: params[:result]) unless params[:result].nil?
    result = result.where(operation_type: params[:type]) unless params[:type].nil?
    result = result.where('DATE(date) = ? ', params[:date]) unless params[:date].nil?
    render json: result
  end

  # GET /logs/1 or /logs/1.json
  def show; end
end
