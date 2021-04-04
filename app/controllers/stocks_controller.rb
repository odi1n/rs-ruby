class StocksController < ApplicationController
    def index
        @stocks = Stock.all
    end

    def show
        @stock = Stock.find(params[:id])
    end

    def edit
        @stock = Stock.find(params[:id])
    end

    def update
        @stock = Stock.find(params[:id])
        if @stock.update(stock_params)
            redirect_to @stock
        else
            render 'edit'
        end
    end

    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.new(stock_params)

        if @stock.save
            redirect_to @stock
        else
            render "new"
        end
    end

    def stock_params
        params.require(:stock).permit(:name, :address, :balance)
    end
end
