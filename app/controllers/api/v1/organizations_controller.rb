class Api::V1::OrganizationsController < ApplicationController
    def index
    @organizations = Organization.all
    render json: @organizations
    end

    def show
    @organization = Organization.find(params[:id])
    render json: @organization
    end

    def new
        @organization = Organization.new
    end

    def create
        @organization = Organization.new(organization_params)
        if @organization.save
        render json: @organization, status: :created
        else
        render json: @organization.errors, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        @organization = Organization.find(params[:id])
        if @organization.update(organization_params)
        render json: @organization, status: :ok
        else
        render json: @organization.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @organization = Organization.find(params[:id])
        @organization.destroy
        render json: @organization
    end

    private

    def set_organization
        @organization = Organization.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Organization not found' }, status: :not_found
    end

    def organization_params
        params.require(:organization).permit(:name, :location, :password)
    end
end
