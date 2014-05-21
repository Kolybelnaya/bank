class RequestsController < ApplicationController

  before_action :set_search

  def new
    @request = Request.new()

    @requests = @q.result
  end

  def create
    @request = Request.new(request_params)
      if @request.save
        redirect_to contact_center_path, notice: print_request(@request)
      else
        render :new
      end
  end


  private

  def set_search
    @q = Request.search(params[:q])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:id, :date, :time, :operator_id, :service, :email, :full_name,
                                    :bank_customer, :bank_account, :question)
  end

  def print_request(request)
    'Ваша заявка будет рассмотрена оператором, ожидайте подтверждения по email; Заявленные дата и время: '+I18n.l(request.date)+I18n.l(request.time.in_time_zone('Tbilisi'))
  end
end