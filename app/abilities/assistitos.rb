Canard::Abilities.for(:assistito) do
  can [:read], Product
  cannot [:create, :update, :destroy], Product
  can [:read,:create, :update, :destroy], Order
  can [:read, :create, :destroy], Cart
end

