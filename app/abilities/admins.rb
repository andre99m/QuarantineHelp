Canard::Abilities.for(:admin) do
  can [:read,:update,:destroy,:create], Product
  cannot [:read,:update,:destroy,:create], Order
  cannot [:read,:update,:destroy,:create], Cart
end
