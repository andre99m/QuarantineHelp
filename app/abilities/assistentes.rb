Canard::Abilities.for(:assistente) do
  cannot [:read, :create, :update, :destroy], Product
  can [:read,:update], Order
  cannot [:destroy,:create], Order
  cannot [:read, :create, :destroy], Cart
end
