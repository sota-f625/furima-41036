class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

<<<<<<< HEAD
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30fc]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30fc]+\z/ }
  validates :birth_day, presence: true
=======



         
>>>>>>> 97b29856c01d6472aa30d8aded29607ff208ecd7
end
