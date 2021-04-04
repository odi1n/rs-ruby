class ProductsController < ApplicationController
    # Открыть страницу перемещения
    def move
        @product = Product.find_by(id: params[:product_id])
        if @product == nil
            redirect_to Stock.find(params[:stock_id])
        end
    end

    # Метод перемещения товара
    def move_update
        product_param = params[:product]
        @product = Product.find_by(:id => params[:product_id], :stock_id => params[:stock_id])

        if Integer(product_param[:count]) < 0 or Integer(product_param[:count]) > @product.count
            render :move
        else
            @product_check = Product.find_by(:name => @product.name, :stock_id => product_param[:stock_id])

            if @product_check == nil
                @product_check = Product.create(:name => @product.name,
                                                :count => @product.count - (@product.count - Integer(product_param[:count])),
                                                :price => @product.price,
                                                :stock_id => product_param[:stock_id])
            else
                @product_check.count += @product.count - (@product.count - Integer(product_param[:count]))
                @product_check.save
            end

            if product_check_count(product_param)
                redirect_to Stock.find(params[:stock_id])
            else
                render :move
            end
        end
    end

    # Открыть страницу продаж
    def sell
        @product = Product.find_by(id: params[:product_id])
        if @product == nil
            redirect_to Stock.find(params[:stock_id])
        end
    end

    # Метод продажи и обновления данных
    def sell_update
        product_param = params[:product]
        @product = Product.find_by(:id => params[:product_id], :stock_id => params[:stock_id])
        if @product == nil or Integer(product_param[:count]) < 0 or Integer(product_param[:count]) > @product.count
            render :sell
        else
            count = @product.count - (@product.count - Integer(product_param[:count]))

            @stock = Stock.find(@product.stock_id)
            @stock.balance += count * @product.price
            @stock.save

            Statistica.create(:stock_id => @product.stock_id,
                              :product_id => @product.id,
                              :much_was => @product.count,
                              :much_was_left => @product.count - Integer(product_param[:count]),
                              :realized => count,
                              :revenue => count * @product.price)

            if product_check_count(product_param)
                redirect_to Stock.find(params[:stock_id])
            else
                render :sell
            end
        end
    end

    private

    def product_check_count(product_param)
        product_count = @product.count - Integer(product_param[:count])
        # if product_count == 0
            # @product.destroy
            # return true
        # else
            @product.count = product_count
            @product.save
            return false
        # end
    end
end
