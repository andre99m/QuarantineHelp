class ProblemsController < ApplicationController
    before_action :authenticate_user!
    def index
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            if(current_user.is_admin? || current_user.is_assistente?)
                redirect_to '/'
            end
        end
    end

    def show
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            if(current_user.is_admin? || current_user.is_assistito?)
                redirect_to '/'
            else
                p=params[:id]
                @order=Order.find(p)
                if @order.emailassistente != current_user.email && @order.stato!="incoda"
                    redirect_to '/'
                else
                    @order.update(:stato => 'accettata')
                    redirect_to '/profile#accepted'
                end
            end
        end
    end

    def edit
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            if(current_user.is_admin? || current_user.is_assistito?)
                redirect_to '/'
            else
                p=params[:id]
                @order=Order.find(p)
                if @order.emailassistente != current_user.email && @order.stato!="incoda"
                    redirect_to '/'
                else
                    authorize! :update, Order, message: "Non sei autorizzato"
                    rifiutis=JSON.parse(@order.rifiuti)
                    utenti=[]
                    assist=""
                    rifiutis.push(current_user.email)
                    @utente=User.where(:roles_mask => 2, :citta => current_user.citta)
                    @utente.each do |user|
                        utenti.push(user) if not rifiutis.include?(user.email)
                    end
                    curr=2345678765434567876545678987654567
                    utenti.each do |person|
                        coords=Math.sqrt(((current_user.long.to_i-(person.long.to_i))**2)+((current_user.lat.to_i-(person.lat.to_i))**2))
                        if(coords<curr)
                            curr=coords
                            assist=person.email
                        end
                    end
                    if (assist=="")
                       @order.update(:stato => 'cancellata', :rifiuti => rifiutis, :emailassistente => "" )
                       redirect_to '/profile'
                    else
                       @order.update!(:stato => 'incoda', :rifiuti => rifiutis, :emailassistente => assist)
                        redirect_to '/profile'
                    end
                end
            end
        end
    end
    def new
        if setted_paramaters?(current_user) then redirect_to change_myinfo_path
        else
            if(current_user.is_admin? || current_user.is_assistito?)
                redirect_to '/'
            else
                p=params[:id]
                @order=Order.find(p)
                if @order.emailassistente != current_user.email && @order.stato!="accettata"
                    redirect_to '/'
                else
                    @order.update(:stato => 'completata')
                    redirect_to '/profile#complete'
                end
            end
        end
    end
end
