class Category1 < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '買ってきたもの系' },
    { id: 3, name: '飲食店系' },
    { id: 4, name: '料理系' },
  ]

  include ActiveHash::Associations
  has_many :items

end