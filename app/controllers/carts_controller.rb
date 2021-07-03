class CartsController < ApplicationController
    before_action :authenticate_user!
    def index
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            authorize! :index, Cart, message: "Non sei autorizzato"
            @all=Cart.where(:emailuser => current_user.email)
        end
    end
    def create
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            authorize! :create, Cart, message: "Non sei autorizzato"
            p=params[:id]
            t=Product.find(p)
            @check=Cart.where(:title => t.title)
            if @check.length!=0
                @current=Cart.where(:title =>t.title).first
                @current.update(:quantity => @current.quantity+1)
            else
                Cart.create!(:emailuser => current_user.email, :title => t.title, :imagePath => t.imagePath, :description => t.description,  :quantity => 1, :iduser => current_user.id)
            end
            redirect_to products_path
        end
    end
    def destroy
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            authorize! :destroy, Cart, message: "Non sei autorizzato"
            id=params[:id]
            if Cart.exists?(id)
                @cart=Cart.find(id)
                @cart.destroy
                redirect_to carts_path
            else
                render html: "Il Prodotto non esiste"
            end
        end
    end
end
