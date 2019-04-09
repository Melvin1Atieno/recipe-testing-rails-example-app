FactoryBot.define do
  factory :recipe do
    name {'Tea'}
    ingredients { 'water, tea_leaves, sugar, milk' }
    process {'mix, bring to boil, serve hot' }
  end
end
