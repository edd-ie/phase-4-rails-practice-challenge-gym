class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with:  :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        gyms = Gym.all
        render json: gyms, except: [:created_at, :updated_at], status: :ok
    end

    def show
        gym = finder
        render json: gym, except: [:created_at, :updated_at], status: :ok
    end

    def destroy
        gym = finder
        gym.destroy
        head :no_content
    end

    def update
        gym = finder
        gym.update!(valid_params)
        render json: gym, except: [:created_at, :updated_at], status: :accepted
    end

    private
        def finder
            Gym.find(params[:id])
        end

        def valid_params
            params.permit(:name, :address)
        end

        def not_found
            render json: {error: "Gym not found"}, status: :not_found
        end

        def unprocessable_entity_response(invalid)
            render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
end
