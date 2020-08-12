class Admin::ContactsController < ApplicationController
    before_action :authenticate_admin!

	# 問い合わせ内容一覧
	def index
        @contacts = Contact.all.order(created_at: :desc)
        @users = User.includes(:contacts)
    end

    # 問い合わせ内容を取得して更新
    def edit
        @contact = Contact.find(params[:id])
    end

    def update
        contact = Contact.find(params[:id]) # contact_mailer.rbの引数を指定
        contact.update(contact_params)
        user = contact.user
        ContactMailer.send_when_admin_reply(user, contact).deliver_now # 確認メールを送信
        redirect_to admin_contacts_path, notice:'回答を送信しました'
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
