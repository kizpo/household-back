class Api::V1::TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :update, :destroy]
    #before_action :authorize_user_for_transaction, only: [:show, :update, :destroy]

    def index
        @transactions = if params[:account_id].present?
                            current_user.transactions.where(account_id: params[:account_id])
                        else
                            current_user.transactions
                        end
        render json: @transactions
    end

    def show
        render json: @transaction
    end

    def create
        @transaction = current_user.transactions.build(transaction_params)
        if @transaction.save
            render json: @transaction, status: :created
        else
            render json: @transaction.errors, status: :unprocessable_entity
        end
    end

    def update
        if @transaction.update(transaction_params)
            render json: @transaction, status: :ok
        else
            render json: @transaction.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @transaction.destroy
        head :no_content
    end

    private

    def set_transaction
        @transaction = Transaction.find(params[:id])
        if @transaction.user_id != current_user.id
            render json: { error: 'Not authorized to access this transaction' }, status: :forbidden
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Account not found' }, status: :not_found
    end

    def transaction_params
        params.require(:transaction).permit(:name, :income, :expense, :date, :category_id, :account_id)
    end

#    def authorize_user_for_transaction
#        unless @transaction.account.user_id == current_user.id
#            render json: { error: 'Not authorized to perform this action' }, status: :forbidden
#        end
#    end
end
