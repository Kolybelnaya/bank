class RequestsController < ApplicationController

  def new
    @request = Request.new()
    @q = Request.search(params[:q])
    @requests = @q.result
  end

  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to contact_center_path, notice: print_request(@request) }
      else
        format.html { render :new }
      end
    end
  end



  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:id, :date, :time, :operator_id, :service, :email, :full_name,
                                    :bank_customer, :bank_account, :question)
  end

  def print_request(request)
    'Ваша заявка будет рассмотрена оператором, ожидайте подтверждения по email; Заявленные дата и время: '+I18n.l(request.date)+I18n.l(request.time)
  end
end