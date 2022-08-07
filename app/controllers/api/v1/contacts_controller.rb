class Api::V1::ContactsController < ApplicationController
    def index
        @contacts = Contact.all
        render json: @contacts, status: :ok
    end

    def create
        new_contact = Contact.new(contact_params)
        new_contact.save()

        render json: new_contact , status: :created
    end

    def destroy
        # begin
            the_contact = Contact.where(id: params[:id]).first
        # rescue StandardError  => e
        #     puts "-- the error #{e} --"
        # end

        if the_contact
            the_contact.destroy
            head(:ok)
        else
            head(:unprocessable_entity)
       end
    end

    def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email)
    end
end
