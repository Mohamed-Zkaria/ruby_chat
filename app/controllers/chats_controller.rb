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
        application_token = params[:application_token]
        new_application_token = params[:new_application_token]
        chat_number = params[:chat_number]
        new_chat_number = params[:new_chat_number]
        messages_count = params[:messages_count]

        return render json {message: "All fields are empty"}, status: :unprocessable_entity if application_token.nil?
        return render json {message: "All fields are empty"}, status: :unprocessable_entity if chat_number
        application = Application.find_by(token: application_token)
        chat = application.chats.where(chat_number: chat_number)

        chat.application_token = new_application_token unless new_application_token.nil?
        chat.messages_count = messages_count unless messages_count.nil?
        if chat.chat_number != chat_number && !Chat.exists?(application_token: application.token, chat_number: chats_count)
            chat.chat_number = new_chat_number
        end
        chat.save

        return render json: chat.to_json(except: :id)
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
