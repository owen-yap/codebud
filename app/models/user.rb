class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo

  has_many :questions
  has_many :messages, foreign_key: 'sender_id'
  has_many :skills, through: :user_skills
  has_many :proposals, through: :questions

  def received_messages
    Messages.where(receiver_id: self.id)
  end
end
