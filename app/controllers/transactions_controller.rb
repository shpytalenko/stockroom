class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
   # @q = Transaction.ransack(params[:q])
   # @transactions = @q.result.page(params[:page])
   # @total_count
  
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
    if params[:q][:created_at_gteq].present?
      params[:q][:created_at_gteq] = params[:q][:created_at_gteq].to_date.beginning_of_day
    end  
    @q = Transaction.ransack(params[:q])
      @transactions  = @q.result
      count_total_plus_and_minus(@transactions)
      count_target(@transactions)
      @transactions = @transactions.page(params[:page])
    
  
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new(:item_id => params[:item_id], :action_type => params[:action_type])
    
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        @item = @transaction.item
        case @transaction.action_type
        when "In"
          @item.amount += @transaction.amount
        when "Out"
          @item.amount = @item.amount - @transaction.amount
        end 
          @item.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    
  def count_target(transactions)
    @users    ={}
    targets  ={}  
    User.find_each do |user|
      Target.find_each do |target|
          total = 0 
          total = user.transactions.where(:target_id => target.id, :action_type => "Out").sum(:amount)
          targets[target.id] = total
      end  
      max_target= targets.max_by{ |k,v| v }[1]
      targets["max_target" => max_target]
      @users["#{user.email}" => targets ]  
      
    end  
    @users
  end

  
    def count_total_plus_and_minus(transactions)
      @total_plus = 0
      @total_by_target = 0
      @total_minus = 0
      @total_transactions = 0 
      transactions.find_each do |t|
         @total_transactions += 1 
         case t.action_type
          when "In"
           @total_plus += t.cost    
          when "Out"
           @total_minus += t.cost    
           #:@total_by_target += t.amount.to_i if t.
          end
      end  

    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:item_id, :action_type, :amount, :target_id, :notes, :user_id)
    end
end
