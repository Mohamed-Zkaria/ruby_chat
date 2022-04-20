class ChatsController < ApplicationController
    def index
        application_token = params[:application_token]
        return render json: {}, status: :not_found if application_token.nil?
        
        application = Application.find_by(token: application_token)
        return render json: {}, status: :not_found if application.nil?

        render json: Chat.where(application_token: application_token).to_json(except: :id)
    end

    def show
        return render json: {}, status: :unprocessable_entity if params[:token].nil?
        application = Chat.find_by(token: params[:application_token], chat_number: params[:chat_number])
        render json: application.to_json(except: :id)
        
    end

    def create
        application_token = params[:application_token]
        return render json: {}, status: :not_found if application_token.nil?
        
        application = Application.find_by(token: application_token)
        return render json: {}, status: :not_found if application.nil?

        chats_count = Chat.where(application_token: application_token).count + 1
        application.chats_count = chats_count
        chat = application.chats.new
        chat.application_token = application.token
        unless Chat.exists?(application_token: application.token, chat_number: chats_count)
            chat.chat_number = chats_count
        else
            chat.chat_number = chats_count + 1
        end

        application.save!
        chat.save!
        render json: chat.to_json(except: :id)
    end

    def update

    end

    def destroy
        chat_number = params[:chat_number]
        application_token = params[:application_token]
        return render json: {}, status: :not_found if application_token.nil?
        
        application = Application.find_by(token: application_token)
        return render json: {}, status: :not_found if application.nil?

        application.chats.find_by(chat_number: chat_number ).destroy!
        application.chats_count -= 1
        application.save
    end

end
