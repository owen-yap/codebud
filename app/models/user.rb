class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo

  has_many :questions, dependent: :destroy
  has_many :messages, foreign_key: 'sender_id', dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills
  has_many :proposals, dependent: :destroy
  has_one :bio, dependent: :destroy

  def received_messages
    Messages.where(receiver_id: id)
  end
end
