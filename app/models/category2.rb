class Category2 < ActiveHash::Base
  self.data = [
    { id: 1, name: '肉' },
    { id: 2, name: '魚' },
    { id: 3, name: '麺' },
    { id: 4, name: '野菜' },
    { id: 5, name: '飲み物' },
    { id: 6, name: 'スイーツ' },
  ]

  include ActiveHash::Associations
  has_many :items
  
end