class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with:  :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        x = Membership.all
        render json: x ,except: [:created_at, :updated_at], status: :ok
    end

    def create
        memberships =  Membership.where(client_id: params[:client_id])
        for x in memberships do
            if x[:gym] == params[:gym_id]
                return render json: {error: "You already have a membership"}, status: :forbidden
            end
        end
        new_membership = Membership.create!(valid_params)
        render json: new_membership, except: [:created_at, :updated_at], status: :created
    end


    private
        def finder
            Membership.find(params[:id])
        end

        def valid_params
            params.permit(:gym_id, :client_id, :charge)
        end

        def not_found
            render json: {error: "Membership not found"}, status: :not_found
        end

        def unprocessable_entity_response(invalid)
            render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
end
