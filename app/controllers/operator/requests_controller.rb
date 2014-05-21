class Operator::RequestsController < ApplicationController
  layout 'operator'
  before_action :check_legacy

  def unaccepted
    @q = current_user.requests.added.search(params[:q])
    @requests = @q.result
  end

  def completed
    @q = current_user.requests.accepted.search(params[:q])
    @requests = @q.result
  end

  def today
    @requests = current_user.requests.accepted.by_date(DateTime.now.to_date)
  end

  def calculations
    @q = current_user.requests.search(params[:q])
    @requests = @q.result.full
    if params[:q] && params[:q][:date_gteq] && params[:q][:date_lteq] && @requests.any?
      @info = MassService.run(@requests, Time.strptime(params[:q][:date_gteq],"%d/%m/%Y").to_date,
                              Time.strptime(params[:q][:date_lteq],"%d/%m/%Y").to_date)
    end
  end

  def edit
    @request = Request.find(params[:id])
    @requests = current_user.requests.by_date(@request.date).where.not(id: @request.id)

  end

  def update
    @request = Request.find(params[:id])
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to edit_operator_request_path(@request), notice: 'Заявка обновлена' }
      else
        format.html { render :edit }
      end
    end
  end

  def accept
    @request = Request.find(params[:request_id])
    @request.accept!
    redirect_to :back
  end

  def start
    @request = Request.find(params[:request_id])
    @request.update_attribute(:start, Time.now)
    redirect_to :back
  end

  def finish
    @request = Request.find(params[:request_id])
    @request.update_attribute(:finish, Time.now)

    redirect_to :back
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Заявка успешно удалена'}
    end
  end

  private

  def check_legacy
    unless current_user.operator?
      redirect_to root_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:id, :date, :time, :operator_id, :service, :email, :full_name,
                                    :bank_customer, :bank_account, :question)
  end
end