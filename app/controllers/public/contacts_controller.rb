class Public::ContactsController < ApplicationController
  before_action :authenticate_user!, only: [:confirm, :create, :index, :show]


  def new
  	@contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
  end

  def create
  	@contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
        redirect_to root_path, notice:'お問い合わせを送信しました。'
    else
        @contacts = Contact.all
        @users = User.all
        render :new
    end
  end

  def index
    @contacts = current_user.contacts.all.order("created_at DESC")
  end

  def show
    @contact = Contact.find(params[:id])
  end

  private
  def contact_params
  	params.require(:contact).permit(:title, :body, :reply)
  end

end
