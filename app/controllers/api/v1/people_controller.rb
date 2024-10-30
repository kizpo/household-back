class Api::V1::PeopleController < ApplicationController
end

module Api
    module V1
    class PeopleController < ApplicationController
        def index
        @people = Person.all
        render json: @people
        end

        def show
        @person = Person.find(params[:id])
        render json: @person
        end

        def create
        @person = Person.new(person_params)
        if @person.save
            render json: @person, status: :created
        else
            render json: @person.errors, status: :unprocessable_entity
        end
        end

        private

        def person_params
        params.require(:person).permit(:name, :age, :address)
        end
    end
    end
end
