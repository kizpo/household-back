class Api::V1::CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]

    def index
        @categories = if params[:user_id].present? && params[:user_id] == current_user.id
                        Category.where(user_id: params[:user_id])
                    else
                        current_user.categories
                    end
        render json: @categories
    end

    def show
        render json: @category
    end

    def create
        @category = current_user.categories.build(category_params)
        if @category.save
            render json: @category, status: :created
        else
            render json: @category.errors, status: :unprocessable_entity
        end
    end

    def update
        if @category.update(category_params)
            render json: @category, status: :ok
        else
            render json: @category.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @category.destroy
        head :no_content
    end

    private

    def set_category
        @category = Category.find(params[:id])
        if @category.user_id != current_user.id
            render json: { error: 'Not authorized to access this category' }, status: :forbidden
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Category not found' }, status: :not_found
    end

    def category_params
        params.require(:category).permit(:name, :user_id)
    end
end
