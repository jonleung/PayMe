class PaymentsController < ApplicationController
  before_filter :auth, :except => [:new, :create, :thanks]
  
  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(params[:payment])
    if @payment.save_with_payment
      session[:payment_id] = @payment.id
      redirect_to :action => 'thanks'
    else
      render :new, :error => "Sorry #{params[:payment][:name]}, your card was unable to be processed. Please check to make sure everything is entered correctly!"
    end
  end
  
  def thanks
    if session[:payment_id].present?
      @payment = Payment.find(session[:payment_id])
      session[:payment_id] = nil
    else
      redirect_to root_path
    end
    
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def auth
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS_TABLE[username]
    end
  end
  
end
