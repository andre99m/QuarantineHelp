require 'httparty'
class UsersController < ApplicationController
    before_action :authenticate_user! , only: [:edit,:show,:update]
    def index
        @prodotts=Product.all.limit(6);
    end
    def edit
        if current_user.citta!=""
            if setted_paramaters?(current_user) 
                stringa=""
                begin
                response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=+"+current_user.indirizzo+"+"+current_user.citta+",%20,+IT&key=AIzaSyDLb7N0VxFe6kSvymsd6yFUIX7GCxJxZRk")
                rescue URI::InvalidURIError
                    stringa="errore"
                    @user=current_user
                end
                if(stringa!="errore")
                    info=JSON.parse(response.body) 
                    if response.code == 200  && info["results"].length!=0
                        current_user.update(:citta =>info["results"][0]["address_components"][3]["long_name"]);
                        current_user.update(:indirizzo => info["results"][0]["address_components"][1]["long_name"]+", "+info["results"][0]["address_components"][0]["long_name"])
                        current_user.update(:long => info["results"][0]["geometry"]["location"]["lng"])
                        current_user.update(:lat =>info["results"][0]["geometry"]["location"]["lat"])
                        redirect_to '/profile'
                    else
                        @user=current_user
                    end
                else 
                    @user=current_user
                end
            end
        else
            @user=current_user
        end
    end

    def show
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            @orders=Order.all
            @user=current_user
        end
    end

    def update
        p=params.require(:user).permit(:citta, :indirizzo, :roles_mask)
        current_user.update(p)
        stringa=""
                begin
                response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=+"+current_user.indirizzo+"+"+current_user.citta+",%20,+IT&key=AIzaSyDLb7N0VxFe6kSvymsd6yFUIX7GCxJxZRk")
                rescue URI::InvalidURIError
                    stringa="errore"
                    @user=current_user
                end
        if(stringa!="errore")
            info=JSON.parse(response.body) 
            if response.code == 200 && info["results"].length!=0
                current_user.update(:citta =>info["results"][0]["address_components"][3]["long_name"]);
                current_user.update(:indirizzo => info["results"][0]["address_components"][1]["long_name"]+", "+info["results"][0]["address_components"][0]["long_name"])
                current_user.update(:long => info["results"][0]["geometry"]["location"]["lng"])
                current_user.update(:lat =>info["results"][0]["geometry"]["location"]["lat"])
                redirect_to '/profile'
            else
                redirect_to change_myinfo_path
            end
        else
            redirect_to change_myinfo_path
        end
    end
end
