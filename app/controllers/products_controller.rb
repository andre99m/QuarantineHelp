class ProductsController < ApplicationController
    before_action :authenticate_user!
    def index 
        
        if current_user.long==""
            redirect_to change_myinfo_path
        else
            authorize! :index, Product, message: "Non sei autorizzato"
            @all=Product.all
        end
    end
    def def new
        
        if current_user.long==""
            authorize! :create, Product, message: "Non sei autorizzato"
            redirect_to change_myinfo_path
        else
        end
    end
    def create
        
        if current_user.long==""
            redirect_to change_myinfo_path
        else
            authorize! :create, Product, message: "Non sei autorizzato"
            p=params.permit(:imagePath, :title, :description, :category)
            Product.create!(p)
            redirect_to products_path
        end
    end

    def edit
        
        if current_user.long==""
            redirect_to change_myinfo_path
        else
            authorize! :update, Product, message: "Non sei autorizzato"
            id=params[:id]
            if Product.exists?(id)
                @product=Product.find(id)
            else
                render html: "Il Prodotto non esiste"
            end
        end
    end
    def update
        
        if current_user.long==""
            redirect_to change_myinfo_path
        else
            authorize! :update, Product, message: "Non sei autorizzato"
            Product.find(params[:id]).update(params.permit(:imagePath, :title, :description, :category))
            redirect_to products_path
        end
    end
    def destroy
        
        if current_user.long==""
            redirect_to change_myinfo_path
        else
            authorize! :destroy, Product, message: "Non sei autorizzato"
            id=params[:id]
            if Product.exists?(id)
                @product=Product.find(id)
                @product.destroy
                redirect_to products_path
            else
                render html: "Il Prodotto non esiste"
            end
        end
    end
end
