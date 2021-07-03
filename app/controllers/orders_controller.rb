class OrdersController < ApplicationController
    before_action :authenticate_user!
    def create
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            authorize! :create, Order, message: "Non sei autorizzato"
            @cart=Cart.where(:iduser => current_user.id)
            titoli=[]
            quantita=[]
            userfrom=""
            assist=""
            @cart.each do |prodotto|
                userfrom=prodotto.emailuser
                titoli.push(prodotto.title)
                quantita.push(prodotto.quantity.to_s)
            end
            @utente=User.where(:roles_mask => 2, :citta => current_user.citta)
            curr=2345678765434567876545678987654567
            @utente.each do |person|
                coords=Math.sqrt(((current_user.long.to_i-(person.long.to_i))**2)+((current_user.lat.to_i-(person.lat.to_i))**2))
                if(coords<curr)
                    curr=coords
                    assist=person.email
                end
            end
            if (assist=="")
                redirect_to error_path
            else
                Order.create!(:emailuser => userfrom, :cartTitoli => titoli, :cartQuantita => quantita, :stato => 'incoda', :rifiuti => [], :emailassistente => assist , :indirizzo => current_user.indirizzo )
                @cart.delete_all
                redirect_to products_path
            end
        end
    end

    def destroy
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            authorize! :destroy, Order, message: "Non sei autorizzato"
            @ordine=Order.find(params[:id])
            if @ordine!=nil && @ordine.emailuser==current_user.email
                @ordine.destroy
                redirect_to '/profile#accodate'
            else
                redirect_to profile_path
            end
        end
    end

end
