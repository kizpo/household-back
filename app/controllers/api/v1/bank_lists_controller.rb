class Api::V1::BankListsController < ApplicationController
    skip_before_action :authenticate_request
    def index
        @bank_lists = BankList.all
        render json: @bank_lists
    end
end
