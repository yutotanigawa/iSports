class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def confirm
        @contact = Contact.new(contact_params)
        if @contact.valid?
            render :action => 'confirm'
        else
            render :action => 'new'
        end
    end

    def create
        @contact = Contact.new(contact_params)
        if params[:back]
            render :action => 'new'
        else
            ContactMailer.received_email(@contact).deliver_now
            render :action => 'create'
        end
    end

    private

    def contact_params
        params.require(:contact).permit(:name, :email, :body)
    end
end
