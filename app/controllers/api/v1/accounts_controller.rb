class Api::V1::AccountsController < ApplicationController
    before_action :set_account, only: [:show, :update, :destroy]

    def index
        @accounts = if params[:user_id].present? && params[:user_id] == current_user.id
                        Account.where(user_id: params[:user_id])
                    else
                        current_user.accounts
                    end
        render json: @accounts
    end

    def show
        render json: @account
    end

    def create
        @account = current_user.accounts.build(account_params)
        if @account.save
            render json: @account, status: :created
        else
            render json: @account.errors, status: :unprocessable_entity
        end
    end

    def update
        if @account.update(account_params)
            render json: @account, status: :ok
        else
            render json: @account.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @account.destroy
        render json: @account
    end

    private

    def set_account
        @account = Account.find(params[:id])
        if @account.user_id != current_user.id
            render json: { error: 'Not authorized to access this account' }, status: :forbidden
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Account not found' }, status: :not_found
    end

    def account_params
        params.require(:account).permit(:name, :balance)
    end
end
