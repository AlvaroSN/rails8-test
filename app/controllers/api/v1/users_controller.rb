module Api
  module V1
    class UsersController < ApplicationController

      def index
        users = User.includes(likes: :product).all
        users_with_products = users.map do |user|
          {
            id: user.id,
            email: user.email,
            likes: user.likes.map do |like|
              {
                id: like.id,
                product: {
                  id: like.product.id,
                  name: like.product.name
                }
              }
            end
          }
        end

        render json: {
          status: 'success',
          data: users_with_products
        }, status: :ok
      end

    end
  end
end