class Admin::ContactsController < ApplicationController
    before_action :authenticate_admin!

	def index
        @contacts = Contact.includes(:user).page(params[:page]).per(10).order(created_at: :desc)
        @users = User.includes(:contacts)
    end

    def edit
        @contact = Contact.find(params[:id])
    end

    def update
        contact = Contact.find(params[:id]) # contact_mailer.rbの引数を指定
        if contact.update(contact_params)
            user = contact.user
            ContactMailer.send_when_admin_reply(user, contact).deliver_now # 確認メールを送信
            redirect_to admin_contacts_path, notice:'回答を送信しました'
        else
            @contact = Contact.find(params[:id])
            render :edit
        end
    end

    def destroy
        contact = Contact.find(params[:id])
        contact.destroy
        @contacts = Contact.all.order(created_at: :desc)
        @users = User.all
        render :index
    end

    private
    def contact_params
        params.require(:contact).permit(:title, :body, :reply)
    end

end
