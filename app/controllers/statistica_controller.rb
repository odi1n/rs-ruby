class StatisticaController < ApplicationController
    def index
        @statistics = Statistica.all
    end
end
