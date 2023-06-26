class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with:  :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        clients = Client.all
        render json: clients, except: [:created_at, :updated_at], status: :ok
    end

    def show
        client = finder
        render json: client, except: [:created_at, :updated_at], include: :memberships ,status: :ok
    end


    private
        def finder
            Client.find(params[:id])
        end

        def valid_params
            params.permit(:name, :address)
        end

        def not_found
            render json: {error: "Client not found"}, status: :not_found
        end

        def unprocessable_entity_response(invalid)
            render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
end
