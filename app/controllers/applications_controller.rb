class ApplicationsController < ApplicationController
    def index
        render json: Application.all.to_json(except: :id)
    end

    def show
        return render json: {}, status: :unprocessable_entity if params[:token].nil?
        application = Application.find_by(token: params[:token])
        render json: application.to_json(except: :id)
        
    end

    def create
        application = Application.new(application_creation_params)
        if application.save
            render json: { toke: application.token, name: application.name}.to_json(except: :id)
        else
            render json: {}, status: :unprocessable_entity
        end
    end

    def update
        return render json: {}, status: :unprocessable_entity if params[:token].nil?
         
        application = Application.find_by(token: params[:token])

        if application.update(application_update_params)
            render json: { token: application.token}.to_json
        else
            render json: {}, status: :unprocessable_entity
        end

    end

    def destroy
        application = Application.find_by(token: params[:token])
        application.destroy
    end

    private

        def application_creation_params
            params.require(:application).permit(:name)
        end

        def application_update_params
            params.require(:application).permit(:token, :name)
        end


end
